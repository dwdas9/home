#!/usr/bin/env bash
# Emit a short orientation block for Claude Code to inject into model context.
#
#   context.sh SessionStart   -> on every new/resumed session
#   context.sh PostCompact    -> right after the conversation is summarized
#
# Reports only VOLATILE facts that no file can hold: current branch, what is
# uncommitted, and which crash-recovery snapshot is newest. The durable facts
# live in CLAUDE.md (auto-loaded) and .claude/STATE.md (pointed at, not inlined).
#
# Depends on git and sed only. jq is deliberately not used: a hook that fails
# when the environment is degraded is worse than no hook.

set -uo pipefail

event=${1:-SessionStart}

root=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
cd "$root" || exit 0

branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo '?')
dirty=$(git status --porcelain 2>/dev/null)
n_dirty=$(printf '%s' "$dirty" | grep -c . || true)
# paste -d takes a CYCLING delimiter list, so ', ' would alternate comma and space.
files=$(printf '%s\n' "$dirty" | sed -n 's/^...//p' | head -8 | paste -sd, - | sed 's/,/, /g')
snap=$(git for-each-ref --sort=-refname --count=1 --format='%(refname)' refs/snapshots/ 2>/dev/null)

# Build the plain-text block.
{
  if [ "$event" = "PostCompact" ]; then
    printf 'The conversation was just compacted, so earlier reasoning is gone.\n'
    printf 'Before continuing: re-read .claude/STATE.md. If it no longer describes what you\n'
    printf 'are actually doing, correct it now, while you still remember.\n\n'
  else
    printf 'Project state (injected automatically — no need to scan the repo):\n\n'
  fi

  printf -- '- READ .claude/CONTENT-BIBLE.md BEFORE WRITING ANY READER-FACING PROSE. Before\n'
  printf '  anything. It is the single source of truth for how this site explains things,\n'
  printf '  it outranks every other note here, and no article ships until it passes the\n'
  printf '  checklist in Part 11.\n'
  printf -- '- Branch: %s\n' "$branch"

  if [ "$n_dirty" -gt 0 ]; then
    printf -- '- Uncommitted: %s file(s): %s\n' "$n_dirty" "$files"
    printf -- '- Uncommitted work may be from a session that died. Read .claude/STATE.md\n'
    printf '  before assuming it is yours, and do not discard it.\n'
  else
    printf -- '- Working tree clean.\n'
  fi

  [ -n "$snap" ] && printf -- '- Newest crash snapshot: %s  (inspect: git diff HEAD %s)\n' "$snap" "$snap"

  if [ "$event" = "SessionStart" ]; then
    printf -- '- Orientation: .claude/STATE.md = in-flight work. .claude/DECISIONS.md = why.\n'
    printf -- '- The nav: block in mkdocs.yml is the full site map. Use it to locate pages\n'
    printf '  instead of globbing or grepping docs/.\n'
  fi
} > /tmp/.cc_ctx_$$ 2>/dev/null || exit 0

# JSON-escape without jq: backslash, quote, CR, tab, then fold newlines to \n.
escaped=$(sed -e 's/\\/\\\\/g' -e 's/"/\\"/g' -e 's/\r//g' -e 's/\t/\\t/g' /tmp/.cc_ctx_$$ \
  | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/\\n/g')
rm -f /tmp/.cc_ctx_$$

printf '{"hookSpecificOutput":{"hookEventName":"%s","additionalContext":"%s"},"suppressOutput":true}\n' \
  "$event" "$escaped"
