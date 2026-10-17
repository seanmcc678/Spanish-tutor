#!/bin/bash
# Runs after every reply: if Fluent changed any progress files, commit them
# and push to GitHub so the next session picks up where this one left off.
cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/../..}" || exit 0

[ -z "$(git status --porcelain -- data results)" ] && exit 0

git add -- data results >/dev/null 2>&1
git commit -q -m "Save Spanish progress $(date -u +%Y-%m-%d\ %H:%M)" -- data results >/dev/null 2>&1 || exit 0

for delay in 2 4 8 16; do
  git push -q origin HEAD:main >/dev/null 2>&1 && exit 0
  sleep "$delay"
done
echo "[Spanish tutor] Couldn't save progress to GitHub. Ask Claude to 'push my progress' before closing." >&2
exit 0
