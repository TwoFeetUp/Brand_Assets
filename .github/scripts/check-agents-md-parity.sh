#!/usr/bin/env bash
# Fails when a CLAUDE.md and an AGENTS.md in the same folder differ, or when one of the two is
# missing. Claude Code reads CLAUDE.md and Codex reads AGENTS.md, so both must hold the same
# instructions. Checks the git index (what will be committed), so it fits a pre-commit hook and CI.
# Allowed: a CLAUDE.md whose only content is "@AGENTS.md" (Claude Code include), a symlink to the
# partner, and <dir>/.claude/CLAUDE.md as the Claude side of <dir>/AGENTS.md when <dir> has no
# CLAUDE.md and <dir>/.claude has no AGENTS.md.
# Fix drift with: cp CLAUDE.md AGENTS.md (or the reverse), then git add both.
set -u
cd "$(git rev-parse --show-toplevel)" || exit 2
fail=0
report() { printf 'agents-md-parity: %s\n' "$1"; fail=1; }
blob() { git rev-parse -q --verify ":$1" 2>/dev/null; }             # staged blob id, empty if absent
mode() { git ls-files -s -- ":(literal)$1" | cut -d' ' -f1; }
content() { git cat-file blob "$1"; }
same() {  # same <claude-path> <agents-path>: identical, stub or symlink to the partner
  local c="$1" a="$2" bc ba
  bc=$(blob "$c"); ba=$(blob "$a")
  [ "$bc" = "$ba" ] && return 0
  [ "$(content "$bc" | tr -d '[:space:]')" = "@AGENTS.md" ] && return 0
  [ "$(mode "$a")" = 120000 ] && [ "$(content "$ba")" = "$(basename -- "$c")" ] && [ "$(dirname -- "$a")" = "$(dirname -- "$c")" ] && return 0
  [ "$(mode "$c")" = 120000 ] && [ "$(content "$bc")" = "$(basename -- "$a")" ] && [ "$(dirname -- "$a")" = "$(dirname -- "$c")" ] && return 0
  return 1
}
has() { [ -n "$(blob "$1")" ]; }
join_path() { if [ "$1" = "." ]; then printf '%s' "$2"; else printf '%s/%s' "$1" "$2"; fi; }
list="${TMPDIR:-/tmp}/agents-md-dirs.$$"
trap 'rm -f "$list"' EXIT
git ls-files -z --cached -- 'CLAUDE.md' 'AGENTS.md' '*/CLAUDE.md' '*/AGENTS.md' \
  | while IFS= read -r -d '' f; do printf '%s\0' "$(dirname -- "$f")"; done | sort -z -u > "$list"
while IFS= read -r -d '' d; do
  c=$(join_path "$d" CLAUDE.md); a=$(join_path "$d" AGENTS.md)
  parent=$(dirname -- "$d")
  if [ "$(basename -- "$d")" = ".claude" ] && has "$c" && ! has "$a" && ! has "$(join_path "$parent" CLAUDE.md)"; then
    pa=$(join_path "$parent" AGENTS.md)   # <dir>/.claude/CLAUDE.md pairs with <dir>/AGENTS.md
    if has "$pa"; then same "$c" "$pa" || report "$c and $pa differ"; else report "$c has no AGENTS.md in $parent"; fi
    continue
  fi
  if has "$a" && ! has "$c" && has "$(join_path "$d" .claude/CLAUDE.md)" && ! has "$(join_path "$d" .claude/AGENTS.md)"; then
    continue   # checked from <dir>/.claude
  fi
  if has "$c" && has "$a"; then
    same "$c" "$a" || report "$c and $a differ"
  elif has "$c"; then
    report "$c has no AGENTS.md beside it"
  else
    report "$a has no CLAUDE.md beside it"
  fi
done < "$list"
[ "$fail" -eq 0 ] && echo "agents-md-parity: ok"
exit "$fail"
