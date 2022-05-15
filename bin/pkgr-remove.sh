#!/usr/bin/env sh
set -e

tar --list -Pf "$1" --strip-components=1 --show-transformed-names \
  | grep -v '/$' \
  | xargs -IFILE rm -vf "$PKGR_EXTRACT_ROOT/FILE"
