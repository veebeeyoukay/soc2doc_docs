#!/usr/bin/env bash
# honesty-grep.sh — the reusable L-2 honesty + banned-token gate for the soc2doc docs.
#
# Run before every content publish. Scans *.mdx and docs.json (NOT this script,
# NOT README.md — those legitimately NAME the banned tokens as forbidden).
#
# Fails (exit 1) if it finds any of:
#   (a) banned parent-brand hexes:            #f47e52 (coral), #fed700 (gold), #573053 (purple)
#   (b) positioning-guide section 8 tokens:   --ink, --pulse, Space Grotesk
#   (c) fabricated audit-claim phrasing:      "we audit/certify/guarantee", "gap analysis" as our capability
#   (d) callable-looking API endpoints:       "GET|POST|PUT|DELETE /...", "curl ... api.soc2doc"
#   (e) fabricated TSC reference:             CC9.4 (not a real Trust Services Criterion)
#   (f) removed parent brand name:            "It's Jen AI" (rebranded to Generation AI LLC, 2026-07-05)
#
# Reviewed negations ("we do NOT perform the audit", "no gap analysis", "does not
# expose a public API") are allowed — a line only counts against category (c) when
# it does NOT also carry a negation token.
#
# Portable to bash 3.2 (macOS default): no mapfile, no `set -u` on empty arrays.

set -eo pipefail

# Resolve the repo root relative to this script so it runs from anywhere.
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || exit 2

# Collect the files in scope: every *.mdx plus docs.json. Nothing else.
FILES=()
while IFS= read -r f; do
  [ -n "$f" ] && FILES+=("$f")
done < <(find . -type f -name '*.mdx' -not -path './.git/*')
[ -f docs.json ] && FILES+=("docs.json")

if [ "${#FILES[@]}" -eq 0 ]; then
  echo "honesty-grep: no *.mdx or docs.json in scope yet — nothing to check."
  echo "honesty-grep: clean"
  exit 0
fi

NEGATION="do not|does not|don't|doesn't|never|no gap|not perform|without|isn't|is not|do NOT|\\bnot\\b|\\bno\\b"
FAIL=0

report() { # $1 = human label, $2 = grep output
  if [ -n "$2" ]; then
    echo "honesty-grep: FAIL — $1"
    printf '%s\n' "$2" | sed 's/^/  /'
    FAIL=1
  fi
}

# (a) banned parent-brand hexes
HITS="$(grep -niE '#(f47e52|fed700|573053)' "${FILES[@]}" 2>/dev/null || true)"
report "banned parent-brand hex (coral/gold/purple reserved for the parent brand)" "$HITS"

# (b) positioning-guide section 8 visual tokens (must not override --s2-* brand)
HITS="$(grep -niE -- '--ink|--pulse|Space Grotesk' "${FILES[@]}" 2>/dev/null || true)"
report "positioning-guide section 8 token (--ink / --pulse / Space Grotesk)" "$HITS"

# (c1) fabricated audit-claim verbs — negations excepted
HITS="$(grep -niE 'we (audit|certify|guarantee)' "${FILES[@]}" 2>/dev/null | grep -viE "$NEGATION" || true)"
report "fabricated audit claim (we audit / certify / guarantee)" "$HITS"

# (c2) "gap analysis" presented as a soc2doc capability — negations excepted
HITS="$(grep -niE 'gap analysis' "${FILES[@]}" 2>/dev/null | grep -viE "$NEGATION" || true)"
report "gap analysis presented as a capability (the free review does NO gap analysis)" "$HITS"

# (d1) callable-looking HTTP endpoints
HITS="$(grep -niE '(GET|POST|PUT|DELETE) /[a-z]' "${FILES[@]}" 2>/dev/null || true)"
report "callable-looking API endpoint (no public API exists — scaffold only)" "$HITS"

# (d2) curl against a soc2doc api host
HITS="$(grep -niE 'curl .*api\.soc2doc' "${FILES[@]}" 2>/dev/null || true)"
report "curl against api.soc2doc (no public API host exists)" "$HITS"

# (e) fabricated Trust Services Criterion reference
HITS="$(grep -niE 'CC9\.4' "${FILES[@]}" 2>/dev/null || true)"
report "fabricated TSC reference (CC9.4 is not a real Trust Services Criterion)" "$HITS"

# (f) removed parent brand name
HITS="$(grep -niE "it's jen ai|its jen ai|itsjen\.ai" "${FILES[@]}" 2>/dev/null || true)"
report "removed parent brand reference (use 'Generation AI LLC' — It's Jen AI retired 2026-07-05)" "$HITS"

if [ "$FAIL" -ne 0 ]; then
  echo "honesty-grep: FAILED — fix the offending lines above before publishing."
  exit 1
fi

echo "honesty-grep: clean (${#FILES[@]} files scanned)"
exit 0
