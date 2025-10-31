#!/bin/sh
set -eu

CACHE_DIR="/node_modules_cache"
MODULES_DIR="/app/node_modules"
LOCKFILE="/app/package-lock.json"
INSTALLED_HASH_FILE="$MODULES_DIR/.package-lock.hash"
CACHE_HASH_FILE="$CACHE_DIR/.package-lock.hash"

if [ ! -f "$LOCKFILE" ]; then
  echo "Error: package-lock.json not found at $LOCKFILE" >&2
  exit 1
fi

LOCKFILE_HASH="$(sha256sum "$LOCKFILE" | cut -d' ' -f1)"
mkdir -p "$CACHE_DIR"
mkdir -p "$MODULES_DIR"

NEED_INSTALL=0

if [ ! -d "$MODULES_DIR" ] || [ -z "$(ls -A "$MODULES_DIR" 2>/dev/null)" ]; then
  NEED_INSTALL=1
elif [ ! -f "$INSTALLED_HASH_FILE" ]; then
  NEED_INSTALL=1
else
  INSTALLED_HASH="$(cat "$INSTALLED_HASH_FILE")"
  if [ "$INSTALLED_HASH" != "$LOCKFILE_HASH" ]; then
    NEED_INSTALL=1
  fi
fi

if [ "$NEED_INSTALL" -eq 1 ]; then
  if [ -f "$CACHE_HASH_FILE" ] && [ "$(cat "$CACHE_HASH_FILE")" = "$LOCKFILE_HASH" ]; then
    echo "Restoring node_modules from cache..."
    rm -rf "$MODULES_DIR"
    mkdir -p "$MODULES_DIR"
    cp -R "$CACHE_DIR"/. "$MODULES_DIR"/
  else
    echo "Installing dependencies with npm ci..."
    npm ci
    LOCKFILE_HASH="$(sha256sum "$LOCKFILE" | cut -d' ' -f1)"
  fi

  echo "$LOCKFILE_HASH" > "$INSTALLED_HASH_FILE"

  rm -rf "$CACHE_DIR"
  mkdir -p "$CACHE_DIR"
  cp -R "$MODULES_DIR"/. "$CACHE_DIR"/
fi

exec "$@"
