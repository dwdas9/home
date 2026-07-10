#!/usr/bin/env bash
# Snapshot the working tree into refs/snapshots/<timestamp>-<label>.
#
# Never touches HEAD, the index, or the working tree. It builds a commit object
# out-of-band using a temporary index, so it is safe to run at any moment —
# including mid-edit — and cannot interfere with anything the user is doing.
#
# Snapshots are ordinary commits reachable from refs/snapshots/*. They are NOT
# pushed (the default refspec only covers refs/heads/*), so they stay local.
#
# Recover with:
#   git for-each-ref --sort=-refname refs/snapshots/     # list
#   git diff HEAD <ref>                                  # what it holds
#   git restore --source=<ref> --worktree -- .           # take it back
#
# Usage: snapshot.sh [label]

set -uo pipefail

root=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
cd "$root" || exit 0
git rev-parse HEAD >/dev/null 2>&1 || exit 0   # no commits yet: nothing to parent onto

label=${1:-auto}
keep=50

tmp_index=$(mktemp) || exit 0
trap 'rm -f "$tmp_index"' EXIT
export GIT_INDEX_FILE="$tmp_index"

git read-tree HEAD          2>/dev/null || exit 0
git add -A                 2>/dev/null || exit 0   # respects .gitignore: no .venv, no site/
tree=$(git write-tree      2>/dev/null) || exit 0

# Nothing changed relative to HEAD.
[ "$tree" = "$(git rev-parse 'HEAD^{tree}')" ] && exit 0

# Identical to the newest existing snapshot: don't stack duplicates.
last=$(git for-each-ref --sort=-refname --count=1 --format='%(objectname)' refs/snapshots/ 2>/dev/null)
if [ -n "$last" ] && [ "$(git rev-parse "$last^{tree}" 2>/dev/null)" = "$tree" ]; then
  exit 0
fi

commit=$(git commit-tree "$tree" -p "$(git rev-parse HEAD)" \
  -m "snapshot($label) $(date -u +%Y-%m-%dT%H:%M:%SZ)") || exit 0

git update-ref "refs/snapshots/$(date -u +%Y%m%dT%H%M%S)-$label" "$commit" || exit 0

# Fixed-width timestamps mean refname sort == chronological sort.
git for-each-ref --sort=-refname --format='%(refname)' refs/snapshots/ \
  | tail -n "+$((keep + 1))" \
  | while IFS= read -r stale; do git update-ref -d "$stale"; done

echo "$commit"
