#!/usr/bin/env bash
set -e

if [ "$PKGR_EXTRACT_ROOT" == "" ] && [ "$EUID" == 0 ] ; then
  PKGR_EXTRACT_ROOT=/
fi

exclude=${2-$(mktemp)}

echo "extracting $1 to $PKGR_EXTRACT_ROOT"
tar -xvPJf "$1" --strip-components=1 --show-transformed-names --directory="$PKGR_EXTRACT_ROOT" --no-overwrite-dir --exclude-from="$exclude"
