#!/usr/bin/env bash
set -e

if [ "$PKGR_EXTRACT_ROOT" == "" ] && [ "$EUID" == 0 ] ; then
  PKGR_EXTRACT_ROOT=/
fi

echo "extracting $1 to $PKGR_EXTRACT_ROOT"
if [ "$2" != "" ] ; then
  tar -xvPJf "$1" --strip-components=1 --show-transformed-names --directory="$PKGR_EXTRACT_ROOT" --no-overwrite-dir --exclude-from="$2"
  exit 0
fi
tar -xvPJf "$1" --strip-components=1 --show-transformed-names --directory="$PKGR_EXTRACT_ROOT" --no-overwrite-dir
