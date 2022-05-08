#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

# /a exists
echo "old-a" > "$PKGR_EXTRACT_ROOT/a"

# and extracting an archive with /a (and /b)
f=$(create_test_tar "a" "b")
./bin/pkgr-extract.sh "$f"

# /a (updated) and /b exists
assert_exists "$PKGR_EXTRACT_ROOT" "a"
assert_exists "$PKGR_EXTRACT_ROOT" "b"
assert_piped "a" < "$PKGR_EXTRACT_ROOT/a"
