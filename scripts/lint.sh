#!/usr/bin/env sh
set -e

curl -L --silent --output shellcheck.tar.xz https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.x86_64.tar.xz
tar -xf shellcheck.tar.xz shellcheck-stable/shellcheck --strip-components 1
./shellcheck -f gcc "$(find . -name '*.sh')"
