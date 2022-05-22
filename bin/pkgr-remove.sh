#!/usr/bin/env bash
set -e

exclude=${2-$(mktemp)}

echo "remove files in $1 from $PKGR_EXTRACT_ROOT"
tar --list -Pf "$1" --strip-components=1 --show-transformed-names --exclude-from="$exclude" \
  | grep -v '/$' \
  | xargs -IFILE rm -vf "$PKGR_EXTRACT_ROOT/FILE"
