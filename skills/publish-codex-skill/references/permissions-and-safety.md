# Permissions and safety

## Minimum local permissions

- Read selected Skill directories and directly referenced resources.
- Read repository status, remotes, branches, and diffs.
- Write only to a confirmed staging checkout or intended repository paths.
- Create a local branch and commit only after scope is confirmed.

## Minimum GitHub permissions

For an existing repository, request only metadata read, contents read/write, and pull-request read/write on the selected repository.

Add only when required and separately disclosed:

- Administration for repository creation or visibility/settings changes.
- Workflows for `.github/workflows` changes.
- Releases for tags or releases.
- Organization permissions required by organization policy.

Prefer selected-repository access over account-wide or organization-wide access.

## Authentication rules

Use an existing GitHub connector authorization or authenticated `gh` session. If unavailable, request the normal authorization flow.

Never scan credential stores, shell history, or unrelated home directories for tokens; print, persist, copy, or embed tokens; request classic PAT scopes by default; weaken repository policy; or store credentials in the Skill or repository.

## Confirmation boundary

One exact final plan may bundle repository creation, branch push, and Draft PR creation. It must name the repository, visibility, branches, files, commit intent, and Draft PR intent. Confirmation expires when that scope changes.

Require a new explicit confirmation before changing visibility/settings outside confirmed creation, changing workflow files, creating tags/releases, writing directly to the default branch, deleting remote content, or force pushing.

Default to a publication branch and Draft PR. Never force push or directly update the default branch unless explicitly requested and permitted by repository policy.
