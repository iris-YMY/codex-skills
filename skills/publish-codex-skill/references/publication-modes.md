# Publication modes

## Project repository

Use when the Skill applies only to one project. Store it under `.agents/skills/<skill-name>` and publish it in that repository's normal feature branch and Draft PR.

## Source collection

Use when one owner maintains several independent Skill source folders in one repository. Fetch the remote first, place the Skill under a stable named directory, preserve unrelated entries, and publish changes through a branch and Draft PR.

## Standalone source repository

Use for an independently maintained or open-source Skill. Keep repository-level README, license, contribution guidance, and release metadata outside the Skill package.

## Plugin distribution

Use when users should install the workflow, when multiple Skills ship together, or when the package includes MCP configuration, connectors, hooks, apps, commands, or marketplace metadata. Use `plugin-creator`; keep versions in `.codex-plugin/plugin.json` and marketplace metadata rather than Skill frontmatter.

## Selection priority

1. Project-only workflow → project repository.
2. Personal or team source maintenance → source collection.
3. Independent open-source development → standalone source repository.
4. Reusable installation or bundled capabilities → Plugin distribution.
