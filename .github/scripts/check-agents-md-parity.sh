#!/usr/bin/env bash
# Fails when a CLAUDE.md and an AGENTS.md in the same folder differ, or when one of the two is
# missing. Rule: Claude Code reads CLAUDE.md, Codex reads AGENTS.md, so both must hold the same
# instructions. Allowed: a CLAUDE.md whose only content is "@AGENTS.md" (Claude Code include), and
# <dir>/.claude/CLAUDE.md as the Claude side of <dir>/AGENTS.md. Checks tracked and staged files.
# Fix drift with: cp CLAUDE.md AGENTS.md (or the reverse), then commit both.
set -u
cd "$(git rev-parse --show-toplevel)" || exit 2
fail=0
report() { echo "agents-md-parity: $1"; fail=1; }
is_stub() { [ "$(tr -d '[:space:]' < "$1")" = "@AGENTS.md" ]; }
git ls-files --cached -- 'CLAUDE.md' 'AGENTS.md' '*/CLAUDE.md' '*/AGENTS.md' \
  | while IFS= read -r f; do dirname -- "$f"; done | sort -u > "${TMPDIR:-/tmp}/agents-md-dirs.$$"
while IFS= read -r d; do
  c="$d/CLAUDE.md"; a="$d/AGENTS.md"
  [ -f "$c" ] || [ -f "$a" ] || continue   # deleted in the working tree
  if [ "$(basename -- "$d")" = ".claude" ] && [ -f "$c" ] && [ ! -f "$a" ] && [ -f "$(dirname -- "$d")/AGENTS.md" ]; then
    continue   # checked from the parent folder
  fi
  if [ ! -f "$c" ] && [ -f "$a" ] && [ -f "$d/.claude/CLAUDE.md" ] && [ ! -f "$d/.claude/AGENTS.md" ]; then
    c="$d/.claude/CLAUDE.md"
  fi
  if [ -f "$c" ] && [ -f "$a" ]; then
    cmp -s -- "$c" "$a" || is_stub "$c" || report "$c and $a differ"
  elif [ -f "$c" ]; then
    report "$c has no AGENTS.md beside it"
  else
    report "$a has no CLAUDE.md beside it"
  fi
done < "${TMPDIR:-/tmp}/agents-md-dirs.$$"
rm -f "${TMPDIR:-/tmp}/agents-md-dirs.$$"
[ "$fail" -eq 0 ] && echo "agents-md-parity: ok"
exit "$fail"
