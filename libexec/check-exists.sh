#!/usr/bin/env bash

file="$PKGR_EXTRACT_ROOT/$1"
if [ -d "$file" ] ; then
  # ignore directories
  exit 0
elif [ -e "$file" ] ; then
  echo "$file"
  exit 1
fi
