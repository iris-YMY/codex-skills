# Publication modes

## Project repository

Use when a Skill applies only to one project. Store it under `.agents/skills/<skill-name>` and publish it through that repository's normal feature branch and Draft PR.

## Source collection

Use when one owner maintains one or more independent Skill source folders in one repository for source control, review, synchronization, or backup. Multiple Skills do not by themselves require Plugin packaging. Fetch first, use stable named directories, preserve unrelated entries, and publish through a branch and Draft PR.

## Standalone source repository

Use for one independently maintained or open-source Skill. Keep repository-level README, license, contribution guidance, and release metadata outside the Skill package.

## Plugin distribution

Use when users should install bundled capabilities as one unit, or when the package includes MCP configuration, connectors, hooks, apps, commands, or marketplace metadata. Use `plugin-creator`; keep versions in `.codex-plugin/plugin.json` and marketplace metadata rather than Skill frontmatter.

## Selection priority

1. Project-only workflow → project repository.
2. Personal or team source maintenance → source collection.
3. Independent open-source development → standalone source repository.
4. Installable bundled capabilities → Plugin distribution.
