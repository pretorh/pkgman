#!/usr/bin/env sh
set -e

echo "remove files in $1 from $PKGR_EXTRACT_ROOT"
tar --list -Pf "$1" --strip-components=1 --show-transformed-names \
  | grep -v '/$' \
  | xargs -IFILE rm -vf "$PKGR_EXTRACT_ROOT/FILE"
