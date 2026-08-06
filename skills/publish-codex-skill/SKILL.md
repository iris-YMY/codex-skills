---
name: publish-codex-skill
description: Validate, package, and publish one or more Codex Skills or a Skill plugin through an explicitly selected GitHub repository and Draft PR. Use when the user asks to publish, share, open-source, back up, distribute, synchronize, or update Codex Skills on GitHub. Choose source collection versus installable Plugin delivery, keep confirmation efficient, and verify remote state.
---

# Publish Codex Skills safely

Read the applicable `AGENTS.md`. Keep inspection, packaging, remote publication, and verification distinct.

## 1. Resolve scope

Resolve the exact source Skill directories and read each `SKILL.md` plus directly referenced resources. Treat the installed/global Skill as the source of truth unless the user selects another source.

Choose:

- **Project repository** for project-only Skills.
- **Source collection** for maintenance, review, and backup of one or more independent Skills.
- **Standalone repository** for one independently maintained Skill.
- **Plugin** only when users need installable bundled delivery, MCP configuration, connectors, hooks, apps, commands, or marketplace metadata.

Read [references/publication-modes.md](references/publication-modes.md) only when the choice is ambiguous. Use `plugin-creator` when Plugin packaging is selected.

Keep repository documentation and Plugin manifests outside Skill directories.

## 2. Preflight

Run `scripts/preflight.ps1` for every selected Skill, passing the `skill-creator` `quick_validate.py` path. It inventories candidate files and flags structural, UTF-8, symlink, nested-repository, cache, credential-shaped, and environment-specific content without printing secret values.

Do not load the full `skill-creator` instructions for routine publication. Load it only when creating or restructuring a Skill, or when validation fails.

Exclude secrets, `.env`, credentials, caches, virtual environments, build outputs, nested repositories, and unrelated files. Disclose environment-specific paths or internal identifiers; they may be acceptable in a confirmed private repository.

## 3. Confirm one exact plan

Use an existing clean checkout when available. Otherwise clone or create a bounded staging checkout. Fetch before deciding whether each Skill is new or updated.

Present source paths, distribution form, repository and visibility, repository creation or packaging changes, branches, exact file changes, validation findings, commit/PR intent, and required permissions.

One explicit confirmation may authorize the listed repository creation, branch push, and Draft PR creation as one bounded transaction. Reconfirm only if scope changes or the operation adds visibility/settings changes, workflow files, releases, direct default-branch writes, force pushes, or destructive actions.

Read [references/permissions-and-safety.md](references/permissions-and-safety.md) when creating a repository, changing permissions/settings, or handling a sensitive finding.

## 4. Publish

After confirmation, use `github:yeet` for intentional staging, commit, push, and Draft PR creation. Load that workflow only at this stage. Prefer the GitHub connector; use authenticated `gh` where connector coverage is insufficient.

Stage only confirmed paths. Before retrying PR creation, query for an existing PR with the same head branch.

If Git transport returns an ambiguous failure, do not infer success from local output. Read [references/recovery.md](references/recovery.md), verify the remote ref, and retry idempotently.

## 5. Verify and report

Read back repository visibility/default branch, remote publication-branch SHA, Draft PR state/base/head/file list, and local worktree status.

Report repository, branch, commit, PR URL, visibility, validation results, disclosed risks, and remaining human review. Do not mark publication complete when remote state is unverified.
