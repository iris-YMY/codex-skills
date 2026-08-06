# macOS Lark-Codex bridge

## Architecture

Keep the Skill, service source, configuration, state, secrets, logs, and LaunchAgent separate:

```text
~/Documents/Codex/services/lark-codex-bridge/  service source
~/.config/lark-codex-bridge/                   non-secret configuration
~/.local/state/lark-codex-bridge/              sessions and deduplication state
~/Library/Logs/lark-codex-bridge/              logs
~/Library/LaunchAgents/                         user LaunchAgent
```

Do not deploy until the user authorizes installation and Feishu authentication.

## Preflight

Run `scripts/inspect_macos_bridge.sh`. Verify:

- an official `lark-cli` executable;
- the actual bundled Codex CLI, commonly under Codex.app or ChatGPT.app;
- application authentication and bot identity;
- the configured workspace;
- existing state, LaunchAgent, processes, and logs.

If Node/npm/npx is absent, use an available trusted runtime only for installation. The unattended service must use stable absolute executable paths and must not depend on an interactive shell profile.

## Security boundary

- Accept only `p2p` messages from an explicit `open_id` allowlist.
- Run Codex in a read-only sandbox unless the user deliberately expands authority.
- Persist `event_id` deduplication and `chat_id` to Codex thread mappings.
- Use stable idempotency keys for replies.
- Add and remove the temporary Typing reaction in a `finally` path.
- Do not record App Secret, access tokens, full authorization responses, or full message bodies.

## LaunchAgent

Use a user LaunchAgent with `RunAtLoad=true`, `KeepAlive=true`, explicit `HOME`, `PATH`, workspace, configuration and log paths. Do not place secrets in the plist. Stop with SIGTERM or closed stdin; never use `kill -9` as the normal update path.

## Acceptance sequence

Do not stop at a successful doctor command. Verify in order:

1. Event consumer reports ready and connected.
2. Bot can send and reply to the allowlisted user.
3. `/status` returns locally without a model call.
4. A normal question receives a temporary Typing reaction.
5. Codex replies to the original message.
6. The reaction is removed on success and failure.
7. Deduplication and session files update.
8. `/new` resets only the current chat session.
9. LaunchAgent remains running without duplicate consumers or restart loops.

Report that group chat, attachment understanding, and document writes remain unsupported unless separately implemented and verified.
