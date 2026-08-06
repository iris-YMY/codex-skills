#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo 'This inspector is for macOS only.' >&2
  exit 2
fi

echo '--- executables ---'
for cmd in lark-cli node npm npx; do
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "$cmd=$(command -v "$cmd")"
  else
    echo "$cmd=MISSING"
  fi
done

for path in \
  /Applications/Codex.app/Contents/Resources/codex \
  /Applications/ChatGPT.app/Contents/Resources/codex \
  "$HOME/Applications/Codex.app/Contents/Resources/codex" \
  "$HOME/Applications/ChatGPT.app/Contents/Resources/codex"; do
  [[ -x "$path" ]] && echo "codex=$path"
done

echo '--- runtime paths ---'
for path in \
  "$HOME/.config/lark-codex-bridge" \
  "$HOME/.local/state/lark-codex-bridge" \
  "$HOME/Library/Logs/lark-codex-bridge" \
  "$HOME/Library/LaunchAgents/com.openai.lark-codex-bridge.plist"; do
  [[ -e "$path" ]] && echo "EXISTS $path" || echo "MISSING $path"
done

echo '--- matching processes ---'
/usr/bin/pgrep -afil 'lark-codex-bridge|lark-cli event consume' 2>/dev/null || true
