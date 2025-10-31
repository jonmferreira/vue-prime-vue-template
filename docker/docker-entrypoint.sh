#!/bin/sh
set -eu

CACHE_DIR="/node_modules_cache"
MODULES_DIR="/app/node_modules"

if [ ! -d "$MODULES_DIR" ] || [ -z "$(ls -A "$MODULES_DIR" 2>/dev/null)" ]; then
  mkdir -p "$MODULES_DIR"
  if [ -d "$CACHE_DIR" ] && [ -n "$(ls -A "$CACHE_DIR" 2>/dev/null)" ]; then
    echo "Populating node_modules from cache..."
    cp -R "$CACHE_DIR"/. "$MODULES_DIR"/
  else
    echo "Warning: node_modules cache not found; installing dependencies..."
    npm ci
  fi
fi

exec "$@"
