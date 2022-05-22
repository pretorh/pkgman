#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

f=$(create_test_tar "a" "b" "c/d" "c/e/f")

./bin/pkgr-check.sh "$f" 2>/dev/null 1>"$TEST_ROOT/stdout" || fail "check failed with exit code $?"
assert_empty_file "$TEST_ROOT/stdout"
