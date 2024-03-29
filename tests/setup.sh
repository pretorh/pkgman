#!/usr/bin/env bash

mktmp_dir() {
  mktemp -d
}

mktmp_dir_in_test_root() {
  dir="$TEST_ROOT/dir-$RANDOM"
  mkdir -p "$dir"
  echo "$dir"
}

TEST_ROOT=$(mktmp_dir)
PKGR_EXTRACT_ROOT=$TEST_ROOT/root
mkdir -p "$PKGR_EXTRACT_ROOT"
export PKGR_EXTRACT_ROOT

trap trap_error ERR

trap_error() {
  fail "ERR signal"
}

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
  local f
  local root=$1
  shift
  for f in "$@" ; do
    test -e "$root/$f" || fail "'$f' does not exist (in $root)"
  done
}

assert_not_exists() {
  root=$1
  shift
  local f
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
  local data
  read -r data

  if [ "$data" != "$expected" ] ; then
    echo "$data" >&2
    fail "invalid piped data (expected $expected)"
  fi
}

assert_grep() {
  local content=$1
  local file=$2
  if ! grep "$content" "$file" ; then
    echo "$file:" >&2
    cat "$file" >&2
    fail "'$1' not found in output"
  fi
}

create_test_tar() {
  local data
  local v
  data="$(mktmp_dir_in_test_root)"
  mkdir -p "$data/root"

  for v in "$@" ; do
    local f="$data/root/$v"
    (
      umask 022
      mkdir -p "$(dirname "$f")"
      echo "$v" > "$f"
    )
  done

  ./bin/pkgr-create.sh "$data" || fail "failed to create tar of $data"
  echo "$data/files.tar.xz"
}

create_exclude_file() {
  local file
  local v
  file="$TEST_ROOT/$RANDOM.skip"
  for v in "$@" ; do
    echo "root/$v" >> "$file"
  done
  echo "$file"
}

if [ "$DEBUG" ] ; then
  echo "pkgr test: $0" >&2
  echo "pkgr test: TEST_ROOT=$TEST_ROOT" >&2
  echo "pkgr test: PKGR_EXTRACT_ROOT=$PKGR_EXTRACT_ROOT" >&2
fi
