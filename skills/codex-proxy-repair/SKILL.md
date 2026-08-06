---
name: codex-proxy-repair
description: Diagnose and safely repair repeated Codex reconnecting, sampling-stream disconnects, WebSocket connection failures, or missing proxy inheritance on macOS or Windows. Use when Codex Desktop, ChatGPT Desktop's Codex surface, the IDE extension, or Codex CLI repeatedly reconnects or cannot reach chatgpt.com. Diagnose before changing settings and never guess a proxy port.
---

# Repair Codex proxy connectivity

Detect the host operating system and read exactly one platform reference:

- macOS: [references/macos-proxy-repair.md](references/macos-proxy-repair.md)
- Windows: [references/windows-proxy-repair.md](references/windows-proxy-repair.md)

## Required behavior

1. Inspect effective proxy variables, system proxy settings, proxy processes, listening ports, and PID ownership before changing anything.
2. Distinguish HTTP, SOCKS, mixed, control, DNS, and API ports. Never treat a control or DNS port as a proxy port.
3. Verify a candidate HTTP or mixed proxy with a short-timeout HTTPS or HTTP CONNECT request before modification.
4. Back up existing non-empty values and modify only the smallest user-scoped configuration proven to be inherited by the installed Codex build.
5. Do not assume `~/.codex/.env` is read. Use it only after local or official evidence verifies that behavior for the installed version.
6. Never reveal credentials or overwrite unrelated configuration.
7. Stop when multiple candidates remain ambiguous.
8. Re-read effective values, confirm the port still listens, and require a full application restart before final verification.

Writes to environment variables, launch settings, or configuration are state changes and require authorization unless already explicitly requested.
