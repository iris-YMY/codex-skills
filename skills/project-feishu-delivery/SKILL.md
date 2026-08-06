---
name: project-feishu-delivery
description: Deliver outputs from the current project to its authorized create-only Feishu folder by either uploading a final local artifact or creating a new Feishu native document. Use when the user asks to upload, deliver, submit, save, publish, or place a project output in Feishu Drive, including requests to create a Feishu document directly instead of uploading Word. In a project workspace, use this Skill for all artifact-delivery tasks. Do not use it for reading sources, connector administration, changing folder authorization, editing existing Feishu documents, or Lark bot operations.
---

# Deliver project outputs to Feishu

Treat the current workspace root as the project boundary. Read the applicable `AGENTS.md` before acting and obey stricter project rules.

Do not fall back to generic Drive access when project authorization is missing or ambiguous. Stop and report the missing mapping.

## Route once

Select exactly one route:

- **Local artifact upload:** PPTX, PDF, XLSX, DOCX, image, archive, or any requested file deliverable. A final local artifact is required.
- **Native Feishu document:** methodology, SOP, summary, plan, memo, minutes, narrative report, or other text-first deliverable that the user wants as an editable Feishu document. A Word file is not required.

If the user explicitly chooses a format, obey it. Otherwise prefer a native Feishu document for collaborative text-first content and a local artifact for layout-sensitive or file-native content.

Never run both routes unless the user explicitly asks for both formats.

## Local artifact upload route

1. Identify the final local artifact and verify it is inside the current project root.
2. Verify it is an output, not a source file or a file under a protected source-data directory.
3. Verify it contains `AI生成，须人工审核` when project rules require it.
4. Verify its filename matches `名称_YYYYMMDD_HHMM_versionXX.扩展名`.
5. Call `list_authorized_output_folders` and select only the independently allowlisted delivery folder for this project. Never use a source folder.
6. Call `prepare_output_upload` with the exact path, destination, and AI-label attestation.
7. Present the file name, byte size, SHA-256, and target folder URL.
8. Stop and wait for explicit confirmation of this exact upload.
9. After confirmation, call `upload_approved_output` with the one-time approval ID. If it expired, prepare again and compare the new plan with the confirmed values.
10. Return the Feishu file URL and retain the local copy.

## Native Feishu document route

Read [native-document.md](references/native-document.md) before drafting or preparing a native document.

1. Draft the document as Feishu DocxXML in memory or a temporary project file. Do not generate DOCX merely as an intermediate.
2. Use a title matching `名称_YYYYMMDD_HHMM_versionXX` without a file extension.
3. Include the visible text `AI生成，须人工审核` when project rules require it. The current connector requires the label for native delivery.
4. Review the complete content for structure, factual consistency, duplicate headings, formatting restraint, and accidental source-data disclosure.
5. Call `list_authorized_output_folders` and select only this project's independently allowlisted delivery folder.
6. Call `prepare_native_document` with the title, XML body, exact active project root, destination, and AI-label attestation.
7. Present the title, character count, SHA-256, outline, and target folder URL. Do not expose the approval ID as a substitute for the plan.
8. Stop and wait for explicit confirmation of this exact creation.
9. After confirmation, call `create_approved_native_document` with the one-time approval ID. If it expired, prepare again and compare the new plan with the confirmed values.
10. Return the native Feishu document URL. Report whether personal full-access permission was granted, skipped, or failed when the connector returns that state.

Do not use this route to edit or overwrite an existing Feishu document. Create a versioned new document instead. Existing-document edits require a separately authorized workflow.

## Shared safety rules

Never deliver automatically as part of content generation. Never overwrite, delete, move, transfer ownership, or change sharing permissions.

If a same-name item exists, stop. Increment `versionXX`, regenerate or update the intended content, rerun preparation, and obtain a new confirmation.

Read [project-setup.md](references/project-setup.md) when a project has no authorized delivery folder or when onboarding a new project.

<!-- AI生成，须人工审核 -->
