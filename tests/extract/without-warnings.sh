#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

f=$(create_test_tar "a")
./bin/pkgr-extract.sh "$f" 2>"$TEST_ROOT/stderr"
if [ -s "$TEST_ROOT/stderr" ] ; then
  cat "$TEST_ROOT/stderr" >&2
  fail "stderr is not empty"
fi
