#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

f=$(create_test_tar "a")
./bin/pkgr-extract.sh "$f" 2>"$TEST_ROOT/stderr"
assert_empty_file "$TEST_ROOT/stderr"
