#!/usr/bin/env bash
set -e
cd "$(dirname "$0")/.."
. tests/setup.sh

[ "$EUID" == 0 ] || fail "run $0 as root (euid=$EUID)"

name=$(uuidgen)
f=$(create_test_tar "tmp/$name/a")
PKGR_EXTRACT_ROOT="" bin/pkgr-extract.sh "$f" 2>"$TEST_ROOT/stderr"

# files created
assert_exists / "tmp/$name/a"
# no warnings
assert_empty_file "$TEST_ROOT/stderr"
# keep metadata
stat -c '%a' "/tmp" | assert_piped "1777"
