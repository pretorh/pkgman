#!/usr/bin/env bash
set -e

if [ "$PKGR_EXTRACT_ROOT" == "" ] && [ "$EUID" == 0 ] ; then
  PKGR_EXTRACT_ROOT=/
fi

tar -xvPJf "$1" --strip-components=1 --directory="$PKGR_EXTRACT_ROOT"
