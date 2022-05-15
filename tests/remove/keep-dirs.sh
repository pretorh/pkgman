#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

f=$(create_test_tar "a" "b/c" "b/d/e")
mkdir -pv "$PKGR_EXTRACT_ROOT/b/d"
mkdir "$PKGR_EXTRACT_ROOT/other"  # not listed

./bin/pkgr-remove.sh "$f"
assert_exists "$PKGR_EXTRACT_ROOT" . b b/d other
