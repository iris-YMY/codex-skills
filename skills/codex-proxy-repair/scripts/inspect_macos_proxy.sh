#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo '{"error":"This inspector is for macOS only"}'
  exit 2
fi

redact_proxy() {
  sed -E 's#(https?://)[^/@[:space:]]+:[^/@[:space:]]+@#\1<redacted>@#g'
}

echo '--- process proxy variables ---'
env | grep -Ei '^(HTTP_PROXY|HTTPS_PROXY|ALL_PROXY|NO_PROXY|http_proxy|https_proxy|all_proxy|no_proxy)=' | redact_proxy || true

echo '--- macOS system proxy ---'
/usr/sbin/scutil --proxy 2>/dev/null || true

echo '--- candidate proxy processes ---'
/usr/bin/pgrep -afil 'clash|mihomo|flclash|v2ray|xray|sing-box|surge' 2>/dev/null || true

echo '--- listening TCP ports ---'
if command -v lsof >/dev/null 2>&1; then
  lsof -nP -iTCP -sTCP:LISTEN 2>/dev/null || true
else
  echo 'lsof unavailable'
fi

echo '--- Codex CLI candidates ---'
for path in \
  /Applications/Codex.app/Contents/Resources/codex \
  /Applications/ChatGPT.app/Contents/Resources/codex \
  "$HOME/Applications/Codex.app/Contents/Resources/codex" \
  "$HOME/Applications/ChatGPT.app/Contents/Resources/codex"; do
  [[ -x "$path" ]] && echo "$path"
done

# Absence of an optional app candidate is diagnostic information, not failure.
exit 0
