#!/usr/bin/env sh

file="$PKGR_EXTRACT_ROOT/$1"
if [ -e "$file" ] ; then
  echo "$file"
  exit 1
fi
