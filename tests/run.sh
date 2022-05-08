#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/../tests/"

failed=0
for test_file in **/*.sh ; do
  echo "# $test_file"
  if bash -e "$test_file" >/dev/null ; then
    echo "ok $test_file"
  else
    echo "not ok $test_file"
    failed=$((failed+1))
  fi
done

echo "$failed failed"
test $failed -eq 0
