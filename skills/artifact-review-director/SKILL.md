---
name: artifact-review-director
description: Orchestrate objective QA, user-facing preview review, revision loops, and final-delivery readiness for formal artifacts other than presentation-specific visual direction. Use with the relevant generator Skill when Codex creates or materially edits DOCX, PDF, XLSX, CSV, images, audio, video, websites, Markdown, JSON, XML, or delivery archives; when the user asks to review, preview, validate, QA, approve, or avoid repeated draft attachments; and before external delivery of consequential artifacts. Do not replace the generator Skill or the presentation-visual-director.
---

# Artifact Review Director

Act as the QA and review orchestration layer around the artifact's owning generator Skill. Keep generation and format-native verification with that Skill.

## Boundaries

- Do not generate or edit an artifact independently of its owning Skill.
- Do not weaken or duplicate a generator Skill's hard verification contract.
- Do not handle PPTX visual direction; use `presentation-visual-director` with Presentations.
- Do not treat user review as a substitute for objective QA.
- Do not claim legal, medical, financial, security, or regulatory approval.
- Keep QA reports and preview intermediates in the task workspace; do not deliver them unless requested.

## Route the Artifact

Always read [common-qa.md](references/common-qa.md), then read exactly the relevant format reference:

- DOCX and PDF: [document-qa.md](references/document-qa.md)
- XLSX, XLS, CSV, and TSV: [spreadsheet-qa.md](references/spreadsheet-qa.md)
- Raster or standalone visual assets: [image-qa.md](references/image-qa.md)
- Audio and video: [audio-video-qa.md](references/audio-video-qa.md)
- Websites and interactive web artifacts: [web-qa.md](references/web-qa.md)
- Markdown, TXT, JSON, XML, YAML, and archives: [structured-data-qa.md](references/structured-data-qa.md)

For a bundle containing several material formats, apply common QA once and each relevant format reference to its members. Avoid reviewing scratch or cache files.

## Workflow

### 1. Classify risk and review need

Set one level:

- `light`: reversible technical or intermediate artifact; QA only unless requested.
- `standard`: formal internal deliverable; full QA and concise user review.
- `high`: external publication, consequential formulas or decisions, production import, or difficult-to-reverse delivery; full QA and explicit user approval.

User instructions override the default review level. External writes remain subject to the delivery Skill's separate confirmation.

### 2. Generate with the owning Skill

Let the owning Skill create or edit the working artifact and perform its required format-native checks. Keep one internal working artifact. Do not deliver versioned drafts merely to obtain feedback.

### 3. Run the QA gate

Apply common and format-specific checks. Fix objective defects through the owning Skill, then rerun affected checks. Record a compact internal `work/qa/review-state.json` or equivalent task-local state when persistent state is useful.

Use these statuses:

- `draft`
- `qa_running`
- `qa_blocked`
- `qa_passed`
- `review_waiting`
- `revision_requested`
- `review_approved`
- `ready_for_delivery`
- `delivered`

Do not enter user review while `qa_blocked`. Never mark `qa_passed` when a required check was skipped; record the limitation and choose whether it blocks delivery.

### 4. Present the review in the right medium

After QA passes, present a compact review packet:

1. QA result and any limitations.
2. What changed or what the artifact contains.
3. Inline preview appropriate to the format.
4. Only the decisions that require user judgment.
5. A clear way to respond by page, section, sheet/range, image region, timestamp, or route.

Default to inline previews, rendered pages, representative ranges, playable media, or a live browser preview. Do not attach a new DOCX, PDF, XLSX, ZIP, or other draft on every review round unless the user asks.

### 5. Iterate narrowly

Translate feedback into targeted changes through the owning Skill. Re-run QA for changed portions and any dependent results. Re-render only affected views plus neighboring context needed to assess flow. Preserve the same working artifact.

### 6. Finalize and hand off

After approval, run the owning Skill's complete final verification and move to `ready_for_delivery`. Deliver once in the requested form. If an external delivery Skill is used, let it perform its own destination, filename, hash, collision, permission, and confirmation checks.

## QA vs Review

- QA answers: “Is the artifact objectively correct, complete, usable, and technically valid?”
- Review answers: “Does this content, emphasis, presentation, or business choice match the user's intent?”

Fix QA defects without asking the user when the correct repair is unambiguous. Ask the user only for genuine choices, missing authority, or consequential ambiguity.

## State Contract

When recording state, use a compact shape such as:

```json
{
  "artifact": "example.xlsx",
  "type": "spreadsheet",
  "risk": "standard",
  "qa_status": "passed",
  "qa_summary": ["No formula errors", "Key totals reconcile"],
  "review_required": true,
  "review_status": "waiting_for_user",
  "review_focus": ["Confirm forecast treatment of holiday months"]
}
```

Do not expose internal paths, scratch reports, or state files unless requested.
