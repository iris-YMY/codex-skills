---
name: presentation-visual-director
description: Provide visual direction, composition constraints, image-sizing rules, render-based visual QA, and attachment-free draft review for presentations. Use together with the installed Presentations skill when the user explicitly asks for better-looking slides, visual/art direction, improved typography or image proportions, visual QA, inline or browser-based review, or to avoid receiving a new PPTX attachment on every review round. Do not use as a second PPTX generator.
---

# Presentation Visual Director

Act as the visual strategy and QA layer around the installed Presentations skill. Let Presentations remain the sole owner of PPTX creation, editing, rendering, and final export.

## Boundaries

- Do not create or edit PPTX independently of Presentations.
- Do not use `python-pptx`, a separate SVG-to-PPTX pipeline, or another presentation engine.
- Do not modify the installed Presentations skill.
- Do not create competing draft PPTX deliverables.
- Keep working decks, renders, contracts, and QA reports in the task's temporary workspace.
- A generated working PPTX is an internal implementation artifact, not a user-facing attachment.
- Deliver, cite, link, copy to a delivery location, or upload a PPTX only after the user has reviewed the rendered preview and explicitly approves export or delivery.
- Do not infer approval from task wording such as “调整”“优化”“做一版” or from the agent considering the requested task complete.
- If Presentations has a harder technical or delivery requirement, follow it. This skill refines visual choices; it does not override the implementation contract.

## Load the Required Guidance

- Read [visual-system.md](references/visual-system.md) before planning a new deck or materially restyling one.
- Read [review-rubric.md](references/review-rubric.md) before inspecting rendered slides or processing review feedback.
- Read both for a complete create-review-export workflow.

## Workflow

### 1. Establish the visual contract

Translate the brief into a compact internal `visual-contract.txt` in the temporary workspace. Define:

- audience, communication job, and desired impression;
- visual style and tone;
- typography scale and density tier;
- grid, margins, and alignment anchors;
- preferred slide archetypes;
- image roles, target prominence, aspect-ratio and crop policy;
- chart treatment and emphasis hierarchy;
- draft review mode: inline renders or persistent local preview.

Make reasonable defaults when the user has not specified these. Ask only when a missing choice would materially change the design.

### 2. Hand implementation to Presentations

Use Presentations to plan and build the deck. Treat `visual-contract.txt` as binding design guidance while respecting user-provided templates and references. Favor a small set of coherent compositions over free placement. Shorten or split content before shrinking type.

### 3. Run internal visual QA before user review

Render every slide. Inspect individual slides at full size and the whole deck as a montage. Apply [review-rubric.md](references/review-rubric.md). Fix hard failures and clear aesthetic failures before showing a draft to the user.

Keep a concise internal `visual-qa.txt` containing slide number, finding, evidence, and action. Do not attach this file unless requested. Do not expose or link the working PPTX at this stage.

### 4. Present the QA result for review without PPTX attachments

Default to one continuous production task:

1. Keep the working PPTX internal and do not provide a clickable file link.
2. Complete internal QA first; fix hard failures before asking the user to review.
3. Report the review findings and material design changes in the conversation.
4. Show representative or changed slide renders inline. For a small deck, show all slides; for a large deck, show a montage plus slides needing a decision.
5. Explicitly ask whether the visual direction is approved before producing a user-facing attachment.
6. If the user requests changes, apply them to the same internal working deck and re-render affected slides plus any neighboring slides needed to judge flow.
7. Repeat the render-review loop without delivering versioned PPTX attachments.

If a persistent local preview is practical, offer or start it when the user asks for browser-based review. Do not introduce an SVG editing pipeline solely for preview. Use rendered slide images as the source of truth unless the active presentation implementation already exposes a faithful interactive preview.

### 5. Finalize only after explicit approval

Treat clear statements such as “可以生成附件”“确认导出”“这版OK” or an explicit upload request as approval. Only then run the complete Presentations validation workflow, render all slides once more, and deliver one final PPTX. Preserve the working source internally only as required by the host workflow.

If the user asks for external delivery such as Feishu upload, complete the applicable delivery preflight and confirmation flow after visual approval. Visual approval does not replace upload confirmation.

## Feedback Translation

Convert subjective feedback into measurable actions without flattening the user's taste:

- “文字太挤” → reduce copy, increase line spacing, enlarge the text area, or split the slide; do not default to smaller type.
- “图片太小” → promote it to hero or split-image status and rebalance the composition.
- “不够高级” → reduce decorative vocabulary, strengthen hierarchy, improve image quality, and increase intentional whitespace.
- “每页都一样” → vary adjacent silhouettes while preserving the same grid and visual system.
- “太像网页/UI” → remove card grids, pills, tabs, and repeated panels; return to flat editorial composition.
- “重点不明显” → ensure one dominant visual element and demote competing elements.

## Output Discipline

- During review, communicate what changed and show renders; do not cite, link, attach, copy, or upload the working PPTX as a deliverable.
- A local PPTX path rendered as a clickable link counts as an attachment and is prohibited before approval.
- Never attach scratch plans, visual contracts, QA ledgers, or preview assets unless requested.
- On final delivery, follow the Presentations skill's required citation and handoff format.
