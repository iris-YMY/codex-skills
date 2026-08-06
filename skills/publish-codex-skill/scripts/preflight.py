#!/usr/bin/env python3
"""Cross-platform, secret-safe publication preflight for one Codex Skill."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import subprocess
import sys
from pathlib import Path


EXCLUDED_DIRECTORIES = {
    ".git",
    ".venv",
    "venv",
    "node_modules",
    "__pycache__",
    ".pytest_cache",
    ".mypy_cache",
    "dist",
    "build",
}
BLOCKED_NAMES = {".env", "credentials.json"}
BLOCKED_SUFFIXES = {".pem", ".pfx", ".p12", ".key"}
TEXT_SUFFIXES = {
    ".md",
    ".txt",
    ".yaml",
    ".yml",
    ".json",
    ".toml",
    ".ps1",
    ".py",
    ".js",
    ".ts",
    ".sh",
}
WINDOWS_USER_PATH = re.compile(r"C:\\Users\\[^\\\s]+", re.IGNORECASE)
PRIVATE_KEY = re.compile(
    r"-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----", re.IGNORECASE
)
CREDENTIAL_ASSIGNMENT = re.compile(
    r"(?:password|passwd|api[_-]?key|access[_-]?token|client[_-]?secret)"
    r"\s*[:=]\s*[^\s<>{}\[\]]{8,}",
    re.IGNORECASE,
)


def arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--skill-path", required=True, type=Path)
    parser.add_argument("--validator-path", required=True, type=Path)
    parser.add_argument(
        "--validator-python",
        default=default_validator_python(),
        help="Python executable that has the validator's dependencies",
    )
    return parser.parse_args()


def default_validator_python() -> str:
    configured = os.environ.get("CODEX_SKILL_VALIDATOR_PYTHON")
    if configured:
        return configured
    venv = Path.home() / ".codex" / "venvs" / "publish-codex-skill"
    candidates = (venv / "bin" / "python", venv / "Scripts" / "python.exe")
    for candidate in candidates:
        if candidate.is_file():
            return str(candidate)
    return sys.executable


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def add_finding(findings: list[dict[str, str]], severity: str, category: str, path: str) -> None:
    findings.append({"severity": severity, "category": category, "path": path})


def main() -> int:
    args = arguments()
    skill = args.skill_path.expanduser().resolve(strict=True)
    validator = args.validator_path.expanduser().resolve(strict=True)
    if not skill.is_dir():
        raise NotADirectoryError(skill)

    findings: list[dict[str, str]] = []
    files: list[Path] = []

    for root, directory_names, file_names in os.walk(skill, followlinks=False):
        root_path = Path(root)
        for name in directory_names:
            path = root_path / name
            relative = path.relative_to(skill).as_posix()
            if path.is_symlink():
                add_finding(findings, "block", "symlink_or_reparse_point", relative)
            if name == ".git":
                add_finding(findings, "block", "nested_git_repository", relative)
            elif name in EXCLUDED_DIRECTORIES:
                add_finding(findings, "block", "generated_or_cache_directory", relative)
        for name in file_names:
            path = root_path / name
            relative = path.relative_to(skill).as_posix()
            if path.is_symlink():
                add_finding(findings, "block", "symlink_or_reparse_point", relative)
                continue
            files.append(path)

    inventory = []
    for path in sorted(files):
        relative = path.relative_to(skill).as_posix()
        inventory.append({"path": relative, "bytes": path.stat().st_size, "sha256": sha256(path)})

        if path.name in BLOCKED_NAMES or path.suffix.lower() in BLOCKED_SUFFIXES:
            add_finding(findings, "block", "credential_shaped_file", relative)

        if path.suffix.lower() not in TEXT_SUFFIXES:
            continue
        try:
            text = path.read_text(encoding="utf-8")
        except UnicodeError:
            add_finding(findings, "review", "utf8_read_failed", relative)
            continue
        if WINDOWS_USER_PATH.search(text):
            add_finding(findings, "review", "user_specific_windows_path", relative)
        if PRIVATE_KEY.search(text):
            add_finding(findings, "block", "private_key_material", relative)
        if CREDENTIAL_ASSIGNMENT.search(text):
            add_finding(findings, "block", "credential_shaped_assignment", relative)

    try:
        completed = subprocess.run(
            [args.validator_python, str(validator), str(skill)],
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="replace",
            check=False,
        )
        validation_output = "\n".join(
            part.strip() for part in (completed.stdout, completed.stderr) if part.strip()
        )
        validation_exit_code = completed.returncode
    except OSError as error:
        validation_output = f"validator could not start: {error}"
        validation_exit_code = 127

    result = {
        "schema": 1,
        "skill_path": str(skill),
        "file_count": len(files),
        "total_bytes": sum(path.stat().st_size for path in files),
        "validation": {
            "passed": validation_exit_code == 0,
            "exit_code": validation_exit_code,
            "output": validation_output,
        },
        "findings": findings,
        "files": inventory,
    }
    print(json.dumps(result, ensure_ascii=False, indent=2))
    blocked = any(item["severity"] == "block" for item in findings)
    return 2 if validation_exit_code != 0 or blocked else 0


if __name__ == "__main__":
    raise SystemExit(main())
