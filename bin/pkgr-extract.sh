#!/usr/bin/env bash
set -e

tar -xvJf "$1" --transform "s,root,," --directory "$PKGR_EXTRACT_ROOT"
