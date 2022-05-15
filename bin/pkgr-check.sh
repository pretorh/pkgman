#!/usr/bin/env bash
set -e
libexec="$(dirname "$0")/../libexec"

tar --list -Pf "$1" --strip-components=1 --show-transformed-names \
  | xargs -n1 sh "$libexec/"check-exists.sh
