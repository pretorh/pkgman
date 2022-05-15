#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

# does not exist
sh ./libexec/check-exists.sh "a"

# output existing file name
touch "$PKGR_EXTRACT_ROOT/a"
sh ./libexec/check-exists.sh "a" >"$TEST_ROOT/stdout" || true
assert_grep "a" "$TEST_ROOT/stdout"

# exit with failure
touch "$PKGR_EXTRACT_ROOT/b"
sh ./libexec/check-exists.sh "b" && fail "expected failed when exists"

# relative to PKGR_EXTRACT_ROOT
PKGR_EXTRACT_ROOT="." sh ./libexec/check-exists.sh "tests/" && fail "expected failed when exists"

# output full path of existing
touch "$PKGR_EXTRACT_ROOT/a"
sh ./libexec/check-exists.sh "a" >"$TEST_ROOT/stdout" || true
assert_grep "^$PKGR_EXTRACT_ROOT/a$" "$TEST_ROOT/stdout"

exit 0
