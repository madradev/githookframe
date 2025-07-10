#!/bin/bash
set -euo pipefail

echo "WARNING: This script will IRREVERSIBLY delete from the current directory:"
echo " - tests/ directory"
echo " - dist/gen.sh"
echo " - .git directory"
echo " - .gitignore"
echo " - README.md"
echo " - setup.sh"
echo " - detach.sh (this script itself)"
echo
read -p "Are you absolutely sure? This cannot be undone! (y/N): " confirm

if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 0
fi

rm -rf tests
rm -f dist/gen.sh
rm -rf .git
rm -f .gitignore README.md setup.sh
rm -- "$0"

echo "Detachment complete. Good luck!"