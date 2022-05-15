#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

f=$(create_test_tar "a")
echo "other" > "$PKGR_EXTRACT_ROOT/other"

./bin/pkgr-remove.sh "$f"
assert_exists "$PKGR_EXTRACT_ROOT" other
