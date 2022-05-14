#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

[ "$CI" == "" ] || exit 5 # todo: does overwrite on github actions?

# given archive with 'a/' as 0755
f=$(create_test_tar "a/b")
stat -c '%a' "$(dirname "$f")/root/a" | assert_piped "755"

# and dir 'a/' exists as 0700
mkdir "$PKGR_EXTRACT_ROOT/a"
chmod 700 "$PKGR_EXTRACT_ROOT/a"
stat -c '%a' "$PKGR_EXTRACT_ROOT/a" | assert_piped "700"

# when extracting
./bin/pkgr-extract.sh "$f"

# files are created, but the (previously existing) directory's access is not changed
assert_exists "$PKGR_EXTRACT_ROOT" "a/b"
stat -c '%a' "$PKGR_EXTRACT_ROOT/a" | assert_piped "700"
