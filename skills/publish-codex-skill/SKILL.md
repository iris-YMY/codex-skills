---
name: publish-codex-skill
description: Validate, package, and publish a Codex Skill or Skill plugin through an explicitly selected GitHub repository and draft pull request. Use when the user asks to publish, share, open-source, back up, distribute, or update a Codex Skill on GitHub. Choose the correct distribution form, reuse skill-creator, plugin-creator, and GitHub publishing workflows, and require exact confirmation before every remote write.
---

# Publish a Codex Skill safely

Read the applicable `AGENTS.md`. Treat validation, packaging, and remote publication as separate stages.

## 1. Inspect and validate

1. Resolve the exact Skill directory and read its `SKILL.md` plus directly referenced resources.
2. Use `skill-creator` guidance and run its `quick_validate.py`.
3. Inventory files, sizes, symlinks, executable scripts, generated caches, environment files, credentials, and nested repositories.
4. Exclude secrets, `.env`, credentials, caches, virtual environments, build outputs, and unrelated files. Never search local files for authentication tokens.
5. Stop if the source scope is ambiguous or contains unsafe material.

## 2. Choose the distribution form

Use [references/publication-modes.md](references/publication-modes.md).

- Keep a project-only workflow in `.agents/skills` and publish it through that project's normal repository PR.
- Use a source collection or standalone source repository for maintenance, review, and backup.
- For reusable installation, multiple Skills, connectors, MCP configuration, hooks, apps, or marketplace delivery, use `plugin-creator` and publish a Plugin.

Do not add `README.md`, version fields, installers, or packaging files inside the Skill merely to publish it. Repository-level documentation and Plugin manifests belong outside the Skill directory.

## 3. Confirm packaging

Before creating a repository or packaging a Plugin, present:

- source Skill path and validated name;
- selected distribution form and reason;
- target owner/repository and visibility;
- proposed repository layout;
- files that packaging will create or modify;
- required local and GitHub permissions.

Wait for explicit confirmation if packaging creates a repository, changes visibility, or writes outside the source workspace.

## 4. Prepare the final publication plan

Use an existing clean checkout when available. Otherwise clone or create a bounded staging checkout. Fetch the remote before deciding whether the Skill is new or updated.

Prepare and show:

- repository and visibility;
- base and publication branch;
- exact added, modified, and deleted files;
- validation results;
- commit message;
- draft PR title and summary;
- any workflow, binary, symlink, or permission-sensitive files.

Stop and wait for explicit confirmation of this exact plan. A prior packaging confirmation does not authorize GitHub writes.

## 5. Publish through the existing GitHub workflow

After confirmation, use `github:yeet` for intentional staging, commit, branch push, and Draft PR creation. Prefer the GitHub connector for repository and PR operations; use authenticated `gh` only where connector coverage is insufficient.

Stage only confirmed paths. Never use force push, embed credentials in URLs, read tokens from files, push directly to the default branch by default, or silently include unrelated changes.

Repository creation, visibility changes, releases, workflow-file changes, direct default-branch pushes, and destructive remote operations each require separate explicit authorization.

## 6. Verify and report

Read back the remote branch or Draft PR. Report repository, branch, commit, PR URL, visibility, validation results, and remaining review steps. Do not mark the publication complete if remote content was not verified.

Read [references/permissions-and-safety.md](references/permissions-and-safety.md) for the minimum permission model.

<!-- AI生成，须人工审核 -->
