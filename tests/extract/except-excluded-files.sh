#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

f=$(create_test_tar "a" "b" "c/d" "c/e/f")
x=$(create_exclude_file "b" "c/d")
./bin/pkgr-extract.sh "$f" "$x"

assert_exists "$PKGR_EXTRACT_ROOT" \
  "a" \
  "c/e/f"
assert_not_exists "$PKGR_EXTRACT_ROOT" \
  "b" \
  "c/d"
