#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

# a package with excluded files
f=$(create_test_tar "a" "b")
x=$(create_exclude_file "a")

# with all files in package exist
touch "$PKGR_EXTRACT_ROOT/a"
touch "$PKGR_EXTRACT_ROOT/b"

# does not remove excluded files
./bin/pkgr-remove.sh "$f" "$x"
assert_exists "$PKGR_EXTRACT_ROOT" a
assert_not_exists "$PKGR_EXTRACT_ROOT" b
