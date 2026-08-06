# Structured text, data, and archive QA

Apply to Markdown, TXT, JSON, XML, YAML, CSV-like machine outputs not covered elsewhere, and ZIP or other delivery bundles.

## QA

- Confirm encoding, newline convention when material, parseability, and schema or structural validity.
- Confirm required keys/fields, types, cardinality, ordering requirements, and identifier preservation.
- Check row/object counts, missing values, duplicates, invalid enums, malformed dates, and unexpected nulls as relevant.
- Check escaping, delimiters, quoting, namespaces, and character normalization.
- Show representative samples and aggregate anomalies; do not dump sensitive or huge content.
- For Markdown/TXT, check heading hierarchy, links, code fences, tables, and accidental internal notes.
- For archives, list members, sizes, hashes when needed, nested archives, unsafe paths, duplicate names, unexpected executables, secrets, and omission of required files.
- Confirm extraction does not rely on absolute paths or parent-directory traversal.

## User review

Low-risk machine artifacts usually need QA only. Require review for production imports, consequential transformations, public publication, sensitive exports, or ambiguous schemas.

Present schema/field summary, counts, representative samples, anomalies, and a concise diff when editing an existing artifact. Invite feedback by key, field, record identifier, or archive member.
