#!/usr/bin/env bash
set -e
libexec="$(dirname "$0")/../libexec"

exclude=${2-$(mktemp)}

tar --list -Pf "$1" --strip-components=1 --show-transformed-names --exclude-from="$exclude" \
  | xargs -n1 sh "$libexec/"check-exists.sh
