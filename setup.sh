#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DIST_DIR="$SCRIPT_DIR/dist"
HOOKS_DIR="$SCRIPT_DIR/hooks"

# Set the core.hooksPath to the hooks directory
git config --global core.hooksPath "$HOOKS_DIR"

echo "Set core.hooksPath to $HOOKS_DIR"

# Generate the hooks
"$DIST_DIR/gen.sh"
