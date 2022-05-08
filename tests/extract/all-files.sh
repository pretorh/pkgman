#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

f=$(create_test_tar "a" "b" "c/d" "c/e/f")

./bin/pkgr-extract.sh "$f"

assert_exists "$PKGR_EXTRACT_ROOT" \
  "a" \
  "b" \
  "c/d" \
  "c/e/f"
