#!/usr/bin/env bash
# Tests that README.md meets the specification's success criteria.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
README="$REPO_ROOT/README.md"
PASS=0
FAIL=0

check() {
  local desc="$1"
  shift
  if "$@"; then
    echo "PASS: $desc"
    PASS=$((PASS + 1))
  else
    echo "FAIL: $desc"
    FAIL=$((FAIL + 1))
  fi
}

# Criterion 1: README exists
check "README.md exists at repository root" test -f "$README"

# Criterion 2: Project purpose is clear (first paragraph mentions idea pool)
check "First paragraph mentions idea pool" grep -qi "idea pool" "$README"

# Criterion 3: Hammurabi is referenced with link
check "Links to https://github.com/hydai/hammurabi" grep -q "https://github.com/hydai/hammurabi" "$README"

# Criterion 4: Idea workflow described — ideas submitted as GitHub issues
check "Explains ideas are submitted as GitHub issues" grep -qi "github issue" "$README"

# Criterion 5: Content is concise (no longer than ~50 lines)
LINE_COUNT=$(wc -l < "$README")
check "README is at most 50 lines (actual: $LINE_COUNT)" test "$LINE_COUNT" -le 50

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
