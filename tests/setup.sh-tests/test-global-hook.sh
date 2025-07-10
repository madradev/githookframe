SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_DIR="$SCRIPT_DIR/testrun-dir"
HOOK_FRAMEWORK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

GLOBAL_HOOKLET_SOURCE="$SCRIPT_DIR/../resources/test-global-hooklet.sh"

# Path to the global hooks dir (adjust accordingly)
GLOBAL_HOOKS_DIR="$HOOK_FRAMEWORK_DIR/hooks"  # or wherever setup installs global hooks

# The global hook file to modify
GLOBAL_PRE_COMMIT_HOOK="$GLOBAL_HOOKS_DIR/pre-commit"

# Backup original
cp "$GLOBAL_PRE_COMMIT_HOOK" "${GLOBAL_PRE_COMMIT_HOOK}.bak"

# Replace the line containing 'Example global hooklet' with the test command
sed -i.bak '/Example global hooklet/c\
echo "Global hooklet triggered!"\
' "$GLOBAL_PRE_COMMIT_HOOK"

# Run your test repo commit as usual
cd "$TEST_DIR"
touch file2.txt
git add file2.txt

COMMIT_OUTPUT=$(git commit -m "Test global hook" 2>&1 || true)

# Check for output
if echo "$COMMIT_OUTPUT" | grep -q "Global hooklet triggered!"; then
  echo "Global hook test passed."
else
  echo "Global hook test failed."
  # Optionally restore hook and exit failure here
fi

# Restore original global hook file
mv "${GLOBAL_PRE_COMMIT_HOOK}.bak" "$GLOBAL_PRE_COMMIT_HOOK"
chmod +x "$GLOBAL_PRE_COMMIT_HOOK"
