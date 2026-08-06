---
name: lark-codex-bridge
description: Deploy, validate, operate, restart, or troubleshoot the macOS or Windows bridge between a Lark/Feishu private-chat bot and local Codex CLI. Use for bot messages, private-chat events, replies, /new, /status, session persistence, launch services or scheduled tasks, authentication, logs, startup, disconnects, or a bot that does not respond. Do not use for reading or uploading Feishu Drive documents.
---

# Operate the Lark-Codex bridge

Detect the host operating system and read exactly one platform reference:

- macOS: [references/macos-bridge-setup.md](references/macos-bridge-setup.md)
- Windows: [references/windows-bridge-setup.md](references/windows-bridge-setup.md)

## Required behavior

1. Inspect the existing installation, configuration, authentication, service registration, processes, state, and logs before changing anything.
2. Preserve allowlisted private chats, read-only isolated Codex workspaces, event deduplication, serialized per-chat work, bounded replies, stable idempotency keys, and no secrets or full message bodies in logs.
3. Use the official Lark CLI package and verify its absolute executable path for unattended operation.
4. Validate receive, send, reply, Codex execution, session resume, `/status`, `/new`, reaction cleanup, deduplication, and restart recovery.
5. Keep credentials in supported authentication storage. Never place secrets in service definitions, arguments, source control, Skill files, or logs.
6. Back up configuration and state before edits. Make the smallest reversible change.
7. Request authorization before installs, authentication flows, service changes, process termination, or other external state changes unless explicitly authorized.
8. Report paths, checks, changes, and remaining manual steps without exposing sensitive values.
