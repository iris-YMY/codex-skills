# macOS Codex proxy diagnosis and repair

## Diagnose

Run `scripts/inspect_macos_proxy.sh` first. Correlate all evidence:

- current process proxy variables;
- macOS network proxy settings from `scutil --proxy`;
- Clash, Mihomo, FlClash, V2Ray, Xray, sing-box, Surge, or similar processes;
- listening ports and owning processes;
- installed Codex CLI and desktop application paths.

Common ports such as 7890–7899, 1080, 1087, and 8080 are hints only. Never select a port without process ownership and protocol evidence.

## Verify a candidate

For an HTTP or mixed proxy, perform a short-timeout request such as:

```bash
curl --proxy http://127.0.0.1:<PORT> --connect-timeout 5 --max-time 10 -I https://chatgpt.com/
```

Do not modify configuration if the request cannot establish a valid HTTPS connection. Do not place proxy credentials in commands that will be logged.

## Choose the inheritance mechanism

Establish how the installed desktop build is launched and what environment it inherits. Check user launch services and current process ancestry. Prefer the smallest proven mechanism.

Do not assume `~/.codex/.env` is supported. Treat the following as candidates to verify, not defaults:

- inherited shell or launcher environment;
- user launch environment through `launchctl`;
- an application-supported configuration file documented or observed for the installed build.

Back up every non-empty value before changing it. Keep `NO_PROXY` limited to local addresses unless the user supplies additional exclusions.

## Verify and report

After modification:

1. Re-read the selected user-scoped configuration.
2. Confirm the proxy process still owns the selected listening port.
3. Repeat the short-timeout proxy request.
4. Ask the user to quit and reopen ChatGPT/Codex or VS Code completely.
5. Recheck reconnect or WebSocket errors.

If errors persist, inspect DNS, TLS interception, corporate policy, and WebSocket blocking without repeatedly changing ports.
