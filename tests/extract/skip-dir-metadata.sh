#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

[ "$CI" == "" ] || skip_todo "does overwrite on github actions?"

# given archive with 'a/' as 0755
f=$(create_test_tar "a/b")
assert_permissions 755 "$(dirname "$f")" "root/a"

# and dir 'a/' exists as 0700
mkdir "$PKGR_EXTRACT_ROOT/a"
chmod 700 "$PKGR_EXTRACT_ROOT/a"
assert_permissions 700 "$PKGR_EXTRACT_ROOT" "a"

# when extracting
./bin/pkgr-extract.sh "$f"

# files are created, but the (previously existing) directory's access is not changed
assert_exists "$PKGR_EXTRACT_ROOT" "a/b"
assert_permissions 700 "$PKGR_EXTRACT_ROOT" "a"
