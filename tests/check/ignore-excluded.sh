#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

# a package
f=$(create_test_tar "a" "b" "c/d" "c/e/f")

# when files already exist
touch "$PKGR_EXTRACT_ROOT/a"

# but they are ignored
x=$(create_exclude_file "a")

# does not match, no output
./bin/pkgr-check.sh "$f" "$x" 2>/dev/null 1>"$TEST_ROOT/stdout" || fail "check failed with exit code $?"
assert_empty_file "$TEST_ROOT/stdout"

# when unignored files exists, it should still fail and list them in stdout
touch "$PKGR_EXTRACT_ROOT/b"
if ./bin/pkgr-check.sh "$f" "$x" 2>/dev/null 1>"$TEST_ROOT/stdout" ; then
  fail "expected check to fail"
fi
assert_grep "/b" "$TEST_ROOT/stdout"
