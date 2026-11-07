#!/usr/bin/env bash
set -euo pipefail

# Shows what changed in mattpocock/skills since the last time you synced,
# so you can decide per file what to take over.
#
#   scripts/upstream-changes.sh          list changes since last sync
#   scripts/upstream-changes.sh <file>   show the upstream diff for one file
#   scripts/upstream-changes.sh --mark   record "I've reviewed up to here"
#
# Taking a change over:
#   untouched by you  ->  git show upstream/main:<upstream-path> > <local-path>
#   changed by you    ->  read the diff, edit your version by hand
#
# The last reviewed upstream commit lives in .upstream-sync.

REPO="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO"

SYNC_FILE=".upstream-sync"
UPSTREAM_URL="https://github.com/mattpocock/skills.git"

if ! git remote get-url upstream >/dev/null 2>&1; then
  git remote add upstream "$UPSTREAM_URL"
fi
git fetch -q upstream main

if [ ! -f "$SYNC_FILE" ]; then
  echo "error: $SYNC_FILE missing. Put the upstream commit you started from in it." >&2
  exit 1
fi
BASE="$(tr -d '[:space:]' < "$SYNC_FILE")"
HEAD="$(git rev-parse upstream/main)"

if [ "${1:-}" = "--mark" ]; then
  echo "$HEAD" > "$SYNC_FILE"
  echo "Marked upstream $HEAD as reviewed. Commit $SYNC_FILE to keep it."
  exit 0
fi

if [ -n "${1:-}" ]; then
  git diff "$BASE" "$HEAD" -- "$1"
  exit 0
fi

if [ "$BASE" = "$HEAD" ]; then
  echo "Nothing new upstream since your last sync."
  exit 0
fi

echo "== Upstream commits since last sync"
git log --oneline --no-merges "$BASE..$HEAD"
echo

# Files you changed yourself since the sync point.
mine="$(git diff --name-only "$BASE" HEAD)"

echo "== Changed upstream"
# Skills that live under a different path here than upstream.
local_path() {
  sed -e 's#skills/engineering/ask-matt/#skills/engineering/ask-levin/#' \
      -e 's#skills/engineering/setup-matt-pocock-skills/#skills/engineering/setup-levin-skills/#' \
      -e 's#skills/misc/git-guardrails-claude-code/#skills/productivity/git-guardrails-claude-code/#' <<<"$1"
}

git diff --name-status "$BASE" "$HEAD" -- skills | while read -r status path rest; do
  path="${rest:-$path}"
  lp="$(local_path "$path")"
  [ "$lp" != "$path" ] && path="$path -> $lp"
  if [ ! -e "$lp" ] && [ "$status" != "A" ]; then
    label="you removed this skill, ignore"
  elif [ "$status" = "A" ]; then
    label="NEW upstream"
  elif grep -qxF "$lp" <<<"$mine"; then
    label="you changed this too: merge by hand"
  else
    label="untouched by you: safe to take over"
  fi
  printf '  %-60s %s\n' "$path" "$label"
done

echo
echo "Diff for one file:  scripts/upstream-changes.sh <file>"
echo "Done reviewing:     scripts/upstream-changes.sh --mark"
