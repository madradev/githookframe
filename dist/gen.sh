#!/bin/bash

HOOKS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../hooks"
DIST_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# List of client-side hooks you want to create pass-through hooks for
HOOKS=(
  pre-commit
  prepare-commit-msg
  commit-msg
  post-commit
  pre-rebase
  post-checkout
  post-merge
  pre-push
  pre-applypatch
  post-applypatch
)

SRC="$DIST_DIR/__hook.dist"

mkdir -p "$HOOKS_DIR"

for hook in "${HOOKS[@]}"; do
  DEST="$HOOKS_DIR/${hook}"
  if [ ! -f "$SRC" ]; then
    echo "Source file $SRC does not exist! Aborting."
    exit 1
  fi

  # Replace all occurrences of '__hook' with target hook name inside the file
  sed "s/__hook/${hook}/g" "$SRC" > "$DEST"
  chmod +x "$DEST"
  echo "Created $DEST from $SRC"
done
