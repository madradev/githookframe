#!/bin/bash
set -euo pipefail

HOOK_FRAMEWORK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Save current global hooksPath (if any)
OLD_HOOKS_PATH=$(git config --global --get core.hooksPath || echo "")

# Run framework setup script
"$HOOK_FRAMEWORK_DIR/setup.sh"


#!/bin/bash
set -euo pipefail

# Create test directory and cd into it
mkdir -p "$SCRIPT_DIR/testrun-dir"
cd "$SCRIPT_DIR/testrun-dir"

# Initialize a new git repository
git init


# Run individual tests
"$SCRIPT_DIR/test-local-hook.sh"
"$SCRIPT_DIR/test-global-hook.sh"

echo "All tests passed successfully."

cd "$SCRIPT_DIR"
rm -rf "$SCRIPT_DIR/testrun-dir"

# Restore previous global hooksPath or unset it if none
if [ -z "$OLD_HOOKS_PATH" ]; then
  git config --global --unset core.hooksPath || true
else
  git config --global core.hooksPath "$OLD_HOOKS_PATH"
fi

echo "Restored previous global core.hooksPath"