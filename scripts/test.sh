#!/usr/bin/env bash
set -e

if [ "$EUID" == 0 ] ; then
  prove --exec bash tests/sudo.sh
else
  prove --exec bash --directives tests/**/*.sh
fi
