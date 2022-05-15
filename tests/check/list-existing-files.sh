#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

# a package
f=$(create_test_tar "a" "b" "c/d" "c/e/f")

# when some files already exist
mkdir -p "$PKGR_EXTRACT_ROOT/c/e"
touch "$PKGR_EXTRACT_ROOT/a"
touch "$PKGR_EXTRACT_ROOT/c/d"
ln -sv "$PKGR_EXTRACT_ROOT/c/d" "$PKGR_EXTRACT_ROOT/c/e/f"

# exit with failure
if ./bin/pkgr-check.sh "$f" 2>/dev/null 1>"$TEST_ROOT/stdout" ; then
  fail "expected check to fail"
fi

# with list of files in output
assert_grep "/a" "$TEST_ROOT/stdout"
assert_grep "/c/d" "$TEST_ROOT/stdout"

# with symlinks in output
assert_grep "/c/e/f" "$TEST_ROOT/stdout"

# does not list directories
grep "/c/$" "$TEST_ROOT/stdout" && fail "should not include directories in output"

exit 0
