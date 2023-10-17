#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/../.."
. tests/setup.sh

dir=$(mktmp_dir_in_test_root)
mkdir "$dir/root"
touch "$dir/root/file1"

./bin/pkgr-create.sh "$dir"

tar=$dir/files.tar.xz
test -f "$tar" || fail "did not create archive"
tar -tf "$tar" | grep "^root/file1$" || fail "missing file in tar file"
