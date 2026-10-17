#!/bin/bash
# Runs at the start of every session: makes sure Fluent is installed and
# that Fluent's progress files live in this repo's data/ folder (so they
# can be saved to GitHub) instead of the temporary ~/.claude/fluent-data.
PROJECT="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
DATA="$PROJECT/data"
LINK="$HOME/.claude/fluent-data"

mkdir -p "$DATA" "$HOME/.claude"

# Point Fluent's default data folder at the repo. If a real folder is
# already there (e.g. setup ran before this hook), move its files in first.
if [ -d "$LINK" ] && [ ! -L "$LINK" ]; then
  cp -rn "$LINK"/. "$DATA"/ 2>/dev/null
  rm -rf "$LINK"
fi
[ -L "$LINK" ] || ln -s "$DATA" "$LINK"

# Fallback in case the environment setup script didn't install the plugin.
if command -v claude >/dev/null && ! claude plugin list 2>/dev/null | grep -q 'fluent@m98'; then
  claude plugin marketplace add m98/fluent >/dev/null 2>&1
  claude plugin install fluent@m98 >/dev/null 2>&1 \
    && echo "[Spanish tutor] Fluent was just installed. If /fluent-learn isn't recognised, start a new session."
fi
exit 0
