#!/usr/bin/env bash
# Tests for README.md based on specification success criteria.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
README="$REPO_ROOT/README.md"
PASS=0
FAIL=0

assert() {
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

# SC1: README.md exists at repository root
assert "README.md exists" test -f "$README"

# SC2: Project is described as an idea pool
assert "Contains 'idea pool'" grep -qi "idea pool" "$README"

# SC3: Hammurabi link is present and correct
assert "Contains Hammurabi link" grep -q "https://github.com/hydai/hammurabi" "$README"

# F1: Project title as top-level heading
assert "Has top-level heading with project name" grep -q "^# vibe-vibe" "$README"

# F2: Ideas tracked as GitHub issues
assert "Mentions GitHub issues" grep -qi "github issues" "$README"

# F3: Describes what Hammurabi does
assert "Describes Hammurabi as AI-powered bot" grep -qi "ai-powered" "$README"

# Valid Markdown: no HTML or custom extensions required
if grep -qE "<[a-zA-Z]" "$README"; then
  echo "FAIL: Uses only standard Markdown (no HTML tags)"
  FAIL=$((FAIL + 1))
else
  echo "PASS: Uses only standard Markdown (no HTML tags)"
  PASS=$((PASS + 1))
fi

echo ""
echo "Results: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
