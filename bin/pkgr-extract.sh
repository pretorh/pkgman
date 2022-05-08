#!/usr/bin/env bash
set -e

tar -xvPJf "$1" --strip-components=1 --directory="$PKGR_EXTRACT_ROOT"
