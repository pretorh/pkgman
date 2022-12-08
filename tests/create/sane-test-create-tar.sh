#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

tar=$(create_test_tar "a" "b/c" "d")

test -f "$tar" || fail "did not create tar file"

tar -tf "$tar" | grep "a$" || fail "missing file in tar file"
tar -tf "$tar" | grep "b/c$" || fail "missing file in tar file"
tar -tf "$tar" | grep "d$" || fail "missing file in tar file"
