#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/.."

find . -name '*.sh' -print0 | xargs -0 shellcheck -f gcc

if grep '#!/usr/bin/env ' bin/* libexec/* | grep -v bash ; then
  echo "all scripts should run as bash" >&2
  exit 1
fi
