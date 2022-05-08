#!/usr/bin/env bash
set -e

tar -xvPJf "$1" --transform "s,root,$PKGR_EXTRACT_ROOT,"
