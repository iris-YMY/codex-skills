# Permissions and safety

## Minimum local permissions

- Read the selected Skill directory and directly referenced resources.
- Read repository status, remotes, branches, and diffs.
- Write only to a confirmed staging checkout or intended repository paths.
- Create a local branch and commit only after scope is confirmed.

## Minimum GitHub permissions

For publishing to an existing repository:

- Metadata: read.
- Contents: read and write on the selected repository.
- Pull requests: read and write.

Add only when required and separately approved:

- Administration: create a repository or change visibility/settings.
- Workflows: modify files under `.github/workflows`.
- Releases: create tags or releases.
- Organization permissions: publish inside an organization with applicable policy.

Prefer selected-repository access over account-wide or organization-wide access.

## Authentication rules

Use an existing GitHub connector authorization or authenticated `gh` session. If unavailable, stop and request the normal authorization flow.

Never:

- scan `.env`, credential stores, shell history, or home directories for tokens;
- print, persist, copy, or embed tokens in remote URLs;
- request classic PAT scopes by default;
- weaken repository or organization policy;
- store credentials in the Skill or repository.

## Remote-write gates

Require exact confirmation before:

- creating a repository;
- changing repository visibility or settings;
- pushing a branch;
- creating or updating a pull request;
- changing workflow files;
- creating tags or releases;
- deleting remote content or force pushing.

Default to a new publication branch and Draft PR. Never force push or directly update the default branch unless the user explicitly requests it and repository policy permits it.
