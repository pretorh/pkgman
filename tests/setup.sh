#!/usr/bin/env bash

fail() {
  echo "Fail: $1" >&2
  caller >&2
  exit 1
}

assert_exists() {
  for f in "$@" ; do
    test -e "$f" || fail "'$f' does not exist"
  done
}

assert_not_exists() {
  for f in "$@" ; do
    if [ -e "$f" ] ; then
      fail "'$f' does exist"
    fi
  done
}
