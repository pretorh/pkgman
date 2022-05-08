#!/usr/bin/env bash

TEST_ROOT=$(mktemp --dir)
PKGR_EXTRACT_ROOT=$TEST_ROOT/root
mkdir -p "$PKGR_EXTRACT_ROOT"
export PKGR_EXTRACT_ROOT

fail() {
  echo "Fail: $1" >&2
  caller 1 >&2
  caller 0 >&2
  exit 1
}

assert_exists() {
  root=$1
  shift
  for f in "$@" ; do
    test -e "$root/$f" || fail "'$f' does not exist (in $root)"
  done
}

assert_not_exists() {
  root=$1
  shift
  for f in "$@" ; do
    if [ -e "$root/$f" ] ; then
      fail "'$f' does exist (in $root)"
    fi
  done
}

assert_empty_file() {
  if [ -s "$1" ] ; then
    cat "$1" >&2
    fail "$1 is not empty"
  fi
}

assert_piped() {
  expected=$1
  read -r data

  if [ "$data" != "$expected" ] ; then
    echo "$data" >&2
    fail "invalid piped data (expected $expected)"
  fi
}

create_test_tar() {
  data="$(mktemp --directory --tmpdir="$TEST_ROOT" XXXXX)"
  mkdir -p "$data/root"

  for v in "$@" ; do
    f="$data/root/$v"
    mkdir -p "$(dirname "$f")"
    echo "v" > "$f"
  done

  tar -cJf "$data/files.tar.xz" --directory="$data" root || fail "failed to create tar of $data"
  echo "$data/files.tar.xz"
}
