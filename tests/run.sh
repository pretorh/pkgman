#!/usr/bin/env sh
set -e
cd "$(dirname "$0")/../tests/"

failed=0
skipped=0
for test_file in **/*.sh ; do
  if bash -e "$test_file" >/dev/null ; then
    echo "ok $test_file"
  elif [ $? = 5 ] ; then
    echo "not ok $test_file # TODO exited with 5"
    skipped=$((skipped+1))
  else
    echo "not ok $test_file"
    failed=$((failed+1))
  fi
done

echo "$failed failed ($skipped skipped)"
test $failed -eq 0
