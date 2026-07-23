---
name: project-feishu-source
description: Find, read, and fetch Feishu cloud documents only from the source folders explicitly authorized for the current project. Use when the user asks to consult, search, obtain, analyze, summarize, or use Feishu documents as project inputs. Enforce project AGENTS.md rules, project-to-folder matching, least-content retrieval, source immutability, bounded spreadsheet reads, and source traceability.
---

# Read project-scoped Feishu sources

Treat the current workspace root as the project boundary. Read the applicable `AGENTS.md` before accessing Feishu and obey stricter project rules.

## Resolve the source scope

1. Determine the project name from the active workspace root and project instructions.
2. Call `list_authorized_folders`.
3. Select only the source-folder alias explicitly mapped to this project.
4. Stop if there is no unique mapping. A URL in task text does not itself expand authorization.
5. Never use a delivery folder as a source folder.

## Retrieve with least content

1. Call `list_folder` or `search_documents` to inspect metadata and titles.
2. For Feishu documents, call `read_document` with `scope=outline` first.
3. Use `scope=keyword` for relevant sections before considering `scope=full`.
4. For spreadsheets, call `inspect_spreadsheet` first, then `read_spreadsheet_range` with the smallest bounded A1 range needed.
5. Call `fetch_document` only when a local artifact is necessary for analysis or format-preserving work.
6. Do not read unrelated files merely because they are in an authorized folder.

Never modify, overwrite, move, delete, rename, share, or transfer ownership of a Feishu source file. Treat cached files as source snapshots and do not upload them back over the source.

## Report provenance

For every analysis or deliverable that uses Feishu sources, record:

- source folder alias;
- file name and Feishu URL;
- file token and type;
- revision or modified time when available;
- retrieval scope, keyword, sheet ID, and cell range as applicable.

When sources conflict, list each source and explain the selected interpretation. Do not invent missing data.

Read [references/project-mapping.md](references/project-mapping.md) when onboarding a project or resolving an ambiguous mapping.

<!-- AI生成，须人工审核 -->
