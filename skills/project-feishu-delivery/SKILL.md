---
name: project-feishu-delivery
description: Prepare and upload AI-generated output files from the current project to that project's explicitly authorized Feishu delivery folder. Use when the user asks to save, deliver, upload, or place a project artifact in Feishu Drive. Enforce project AGENTS.md rules, project-root containment, create-only delivery, exact-file confirmation, versioned filenames, local retention, and source-folder isolation.
---

# Deliver project outputs to Feishu

Treat the current workspace root as the project boundary. Read the applicable `AGENTS.md` before acting and obey stricter project rules.

## Required workflow

1. Identify the final local artifact and verify it is inside the current project root.
2. Verify the artifact is an output, not a source file or a file under a protected source-data directory.
3. Verify the artifact contains `AI生成，须人工审核` when project rules require it.
4. Verify the filename matches `名称_YYYYMMDD_HHMM_versionXX.扩展名`.
5. Call `list_authorized_output_folders` and select only the independently allowlisted delivery folder for this project. Never use a source folder.
6. Call `prepare_output_upload` with the exact path, destination, and AI-label attestation.
7. Present the file name, byte size, SHA-256, and target folder URL to the user.
8. Stop and wait for explicit confirmation of this exact upload.
9. After confirmation, call `upload_approved_output` with the one-time approval ID. If the ID expired, prepare again and compare the new plan with the confirmed values.
10. Return the Feishu file URL and retain the local copy.

Never upload automatically as part of file generation. Never overwrite, delete, move, transfer ownership, or change sharing permissions.

If a same-name file exists, stop. Increment `versionXX`, regenerate or copy the intended artifact under the new name, rerun preparation, and obtain a new confirmation.

Read [references/project-setup.md](references/project-setup.md) when a project has no authorized delivery folder or when onboarding a new project.

<!-- AI生成，须人工审核 -->
