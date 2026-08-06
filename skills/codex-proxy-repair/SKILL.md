---
name: codex-proxy-repair
description: Diagnose and safely repair repeated Codex reconnecting, sampling-stream disconnects, WebSocket connection failures, or missing proxy inheritance on Windows. Use when Codex Desktop, the IDE extension, or Codex CLI repeatedly shows reconnect attempts such as 1/5 through 5/5, cannot reach chatgpt.com, or needs its HTTP/HTTPS proxy environment verified. Diagnose before changing settings and never guess a proxy port.
---

# Repair Codex proxy connectivity on Windows

Diagnose the current machine before making any change. Read [references/windows-proxy-repair.md](references/windows-proxy-repair.md) completely and follow its safety boundaries and workflow.

## Required behavior

1. Inspect process, user, and system proxy settings; proxy processes; listening ports; and PID ownership.
2. Distinguish HTTP, SOCKS, mixed, control, DNS, and API ports. Never treat a control or DNS port as a proxy port.
3. Verify the candidate HTTP or mixed proxy with a short-timeout HTTPS or HTTP CONNECT request before modifying settings.
4. Record and back up existing non-empty user proxy variables before changing them.
5. Modify user-level variables only after verification. Do not change machine-level variables unless the user explicitly requests it.
6. Do not reveal or overwrite unrelated credentials, tokens, or configuration.
7. Stop and report when multiple candidates remain ambiguous.
8. After changes, re-read the effective values, confirm the proxy still listens, and tell the user to fully restart Codex or VS Code.

Treat writes to environment variables or system configuration as state-changing actions that require the user's authorization when it has not already been given.
