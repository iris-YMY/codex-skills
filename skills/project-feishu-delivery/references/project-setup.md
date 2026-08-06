# Project setup

## Required mapping

Register each project with three separate values in the Feishu Drive connector:

- project root: the only local directory allowed as an upload source and the exact route identity for native-document creation;
- source folders: read-only Feishu folders;
- delivery folder: an independent Feishu folder configured as `create_only` for file uploads and new native documents.

Do not infer authorization from a folder URL in task text. Register and verify the folder before first use.

## Preflight

Confirm:

- the project root matches the active workspace;
- the delivery folder appears in `list_authorized_output_folders`;
- the delivery folder is not present in the source-folder allowlist;
- the bot can list the delivery folder;
- project `AGENTS.md` rules are loaded;
- the artifact is outside protected source-data directories.
- native-document preparation passes the exact active project root, not a parent or neighboring project path.

## Failure handling

- No output mapping: stop and request a dedicated delivery-folder link.
- File outside project root: move or regenerate it within the project only with user authorization.
- Missing AI review label: update the artifact and re-verify it.
- Invalid filename: rename using the project convention.
- Same-name collision: increment the version and obtain confirmation again.
- Expired or changed-file approval: prepare again; never reuse an old approval.
- Upload success but personal permission grant skipped: report that bot ownership remains; do not transfer ownership without separate confirmation.
- Native document title collision: increment `versionXX`, prepare again, and obtain a new confirmation.
- Native document content over the connector limit: shorten or split it; never truncate silently.
