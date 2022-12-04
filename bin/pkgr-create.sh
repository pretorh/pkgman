#!/usr/bin/env bash
set -e

data=${1?'need the parent directory of root direction to archive as first argument'}
tar -cJf "$data/files.tar.xz" --directory="$data" root
