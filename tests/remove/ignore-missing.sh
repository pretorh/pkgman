#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

f=$(create_test_tar "a")
assert_not_exists "$PKGR_EXTRACT_ROOT" a

./bin/pkgr-remove.sh "$f" || fail "remove failed unexpectedly"
