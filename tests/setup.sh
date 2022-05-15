#!/usr/bin/env bash

TEST_ROOT=$(mktemp --dir)
PKGR_EXTRACT_ROOT=$TEST_ROOT/root
mkdir -p "$PKGR_EXTRACT_ROOT"
export PKGR_EXTRACT_ROOT

fail() {
  echo "Fail: $1" >&2
  caller 1 >&2 || true
  caller 0 >&2
  find "$TEST_ROOT" >&2
  exit 1
}

skip_todo() {
  echo "TODO: $1" >&2
  exit 5
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

assert_grep() {
  content=$1
  file=$2
  if ! grep "$content" "$file" ; then
    echo "$file:" >&2
    cat "$file" >&2
    fail "'$1' not found in output"
  fi
}

create_test_tar() {
  data="$(mktemp --directory --tmpdir="$TEST_ROOT" XXXXX)"
  mkdir -p "$data/root"

  for v in "$@" ; do
    f="$data/root/$v"
    (
      umask 022
      mkdir -p "$(dirname "$f")"
      echo "$v" > "$f"
    )
  done

  tar -cJf "$data/files.tar.xz" --directory="$data" root || fail "failed to create tar of $data"
  echo "$data/files.tar.xz"
}

if [ "$DEBUG" ] ; then
  echo "pkgr test: $0" >&2
  echo "pkgr test: TEST_ROOT=$TEST_ROOT" >&2
  echo "pkgr test: PKGR_EXTRACT_ROOT=$PKGR_EXTRACT_ROOT" >&2
fi
