# Common QA and review gate

Apply this reference to every formal artifact.

## QA checks

- Confirm the artifact opens or parses in its intended format.
- Confirm the extension, media type, and actual format agree.
- Confirm requested sections, fields, sheets, assets, and outputs are present.
- Remove unresolved placeholders, TODOs, sample data, prompts, internal notes, and accidental empty components.
- Confirm title, date, version, units, language, and requested metadata.
- Verify citations and externally sourced assets are traceable when required.
- Check for accidental disclosure of secrets, credentials, personal data, protected source material, or internal-only notes.
- Confirm the artifact is the latest reviewed working version and no stale variant is being delivered.
- Keep scratch builders, renders, QA logs, and caches out of final deliverables.

## Risk levels

- `light`: reversible conversion, machine intermediate, or low-consequence internal output. Run compact QA; user review is optional.
- `standard`: formal internal deliverable or artifact with meaningful content/design choices. Run full QA and user review.
- `high`: external publication, production import, consequential model, sensitive content, or difficult-to-reverse action. Run full QA, disclose limitations, and require explicit approval.

## Review packet

Present:

- `QA: passed`, `QA: blocked`, or `QA: passed with limitations`;
- a short list of checks and automatic fixes;
- an inline preview or structured summary;
- no more than a few genuine decisions at once;
- a locator-based feedback instruction.

Do not ask the user to find clipping, broken formulas, missing pages, parse failures, or other objective defects.

## Handoff rules

- After any content or layout change, rerun affected QA.
- Before final delivery, rerun complete mandatory verification from the owning Skill.
- Keep user content approval distinct from external-write confirmation.
- Never state that QA proves professional, legal, financial, medical, or regulatory correctness.
