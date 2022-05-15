#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

f=$(create_test_tar "a" "b")
echo "a" > "$PKGR_EXTRACT_ROOT/a"
echo "b" > "$PKGR_EXTRACT_ROOT/b"

./bin/pkgr-remove.sh "$f"

assert_not_exists "$PKGR_EXTRACT_ROOT" a b
