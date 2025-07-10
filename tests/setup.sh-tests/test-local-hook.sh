SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_DIR="$SCRIPT_DIR/testrun-dir"

LOCAL_HOOKLET_SOURCE="$SCRIPT_DIR/../resources/test-local-hooklet.sh"

# Path to the test repo's native hooks dir
LOCAL_HOOKS_DIR="$TEST_DIR/.git/hooks"

mkdir -p "$LOCAL_HOOKS_DIR"

# Copy the example local hooklet to the local hooks dir as the relevant hook name (e.g., pre-commit)
cp "$LOCAL_HOOKLET_SOURCE" "$LOCAL_HOOKS_DIR/pre-commit"
chmod +x "$LOCAL_HOOKS_DIR/pre-commit"

# create a test file and add it to the staging area
touch test-file.txt
git add test-file.txt

# Attempt commit and capture output
COMMIT_MSG="Test commit for hook"
COMMIT_OUTPUT=$(git commit -m "$COMMIT_MSG" 2>&1 || true)

echo "Commit output: $COMMIT_OUTPUT"


# Check if the commit output contains the expected local hooklet output
EXPECTED_LOCAL_HOOKLET_OUTPUT="Running test local hooklet"

if echo "$COMMIT_OUTPUT" | grep -q "$EXPECTED_LOCAL_HOOKLET_OUTPUT"; then
  echo "E2E test passed: local hooklet output found."
  exit 0
else
  echo "E2E test failed: expected output not found."
  exit 1
fi