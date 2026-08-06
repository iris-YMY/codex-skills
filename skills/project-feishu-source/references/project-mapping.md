# Project source mapping

## Required mapping

Register every project source folder in the Feishu Drive connector's read-only `folders` allowlist. Use a stable alias that clearly maps to the project name.

Keep these categories separate:

- project source folder: read-only;
- project delivery folder: `create_only`;
- local cache: downloaded or exported snapshots for analysis.

Do not register a source folder as an output folder.

## Preflight

Confirm:

- the active workspace is the intended project;
- applicable `AGENTS.md` instructions are loaded;
- exactly one authorized source alias maps to the project;
- the bot can list that source folder;
- requested files are relevant to the stated task;
- the retrieval method uses the smallest necessary content scope.

## Ambiguity and failures

- No project match: request configuration of the project's source-folder link.
- Multiple matches: show aliases and ask the user which mapping is canonical.
- Folder URL not registered: do not read it until it is explicitly added to the allowlist.
- Missing permission: report the missing scope or exact Feishu authorization issue.
- Unsupported file type: fetch only through an approved format or ask for a supported copy.
- Conflicting facts: preserve all source references and state the decision basis.

## Provenance record

Use this compact structure in working notes or reports:

`folder | file | url | token | type | revision_or_modified | scope_or_range`
