#!/usr/bin/env bash
# Tests for LICENSE file presence and content
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LICENSE_FILE="$REPO_ROOT/LICENSE"
PASS=0
FAIL=0

pass() { PASS=$((PASS + 1)); echo "PASS: $1"; }
fail() { FAIL=$((FAIL + 1)); echo "FAIL: $1"; }

# Test 1: LICENSE file exists
if [[ -f "$LICENSE_FILE" ]]; then
  pass "LICENSE file exists at repository root"
else
  fail "LICENSE file does not exist at repository root"
fi

# Test 2: File contains MIT License header
if head -1 "$LICENSE_FILE" | grep -q "^MIT License$"; then
  pass "LICENSE starts with 'MIT License'"
else
  fail "LICENSE does not start with 'MIT License'"
fi

# Test 3: Copyright line is correct
if grep -q "Copyright (c) 2025 hydai" "$LICENSE_FILE"; then
  pass "Copyright line is 'Copyright (c) 2025 hydai'"
else
  fail "Copyright line is missing or incorrect"
fi

# Test 4: Contains the full permission grant clause
if grep -q "Permission is hereby granted, free of charge" "$LICENSE_FILE"; then
  pass "Contains permission grant clause"
else
  fail "Missing permission grant clause"
fi

# Test 5: Contains the warranty disclaimer
if grep -q "THE SOFTWARE IS PROVIDED \"AS IS\"" "$LICENSE_FILE"; then
  pass "Contains warranty disclaimer"
else
  fail "Missing warranty disclaimer"
fi

# Test 6: File has no extension (named exactly LICENSE)
if [[ "$(basename "$LICENSE_FILE")" == "LICENSE" ]]; then
  pass "File is named exactly 'LICENSE' (no extension)"
else
  fail "File is not named 'LICENSE'"
fi

echo ""
echo "Results: $PASS passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && exit 0 || exit 1
