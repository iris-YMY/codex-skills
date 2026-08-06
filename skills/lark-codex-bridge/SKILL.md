---
name: lark-codex-bridge
description: Deploy, validate, operate, or troubleshoot a Windows bridge between a Lark/Feishu private-chat bot and local Codex CLI. Use for Lark CLI authentication, im.message.receive_v1 event consumption, allowlisted p2p messages, Codex session persistence, /new and /status commands, Windows scheduled-task startup, bridge logging, or failures in the existing LarkCodexBridge installation.
---

# Operate the Lark-Codex bridge on Windows

Read [references/windows-bridge-setup.md](references/windows-bridge-setup.md) completely before implementing or changing the bridge. Treat the paths and identifiers in that document as installation-specific values to verify, not universal defaults.

## Required behavior

1. Inspect the existing installation, configuration, authentication state, scheduled task, processes, and logs before changing anything.
2. Preserve the security boundary: allowlisted private chats only, read-only isolated Codex workspace, event deduplication, serialized per-chat work, bounded replies, and no secrets or full message bodies in logs.
3. Use the official Lark CLI package and verify its absolute executable path for unattended operation.
4. Validate receive, send, reply, Codex execution, session resume, `/status`, `/new`, reaction cleanup, deduplication, and restart recovery.
5. Keep credentials managed by the supported authentication mechanism; never place secrets in task arguments, source control, or logs.
6. Back up existing configuration and state before edits. Make the smallest reversible change.
7. Request authorization before installs, authentication flows, scheduled-task changes, process termination, or other external state changes unless the user already authorized them.
8. Report paths, checks performed, changes made, and any remaining manual steps without exposing sensitive values.
