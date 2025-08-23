#!/bin/sh
BRANCH=$(git rev-parse --abbrev-ref HEAD)

if echo "$BRANCH" | grep -Eq '^(feature|bugfix|hotfix|release|develop|main|master)(/|$)'; then
  echo "✅ Branch name is valid: $BRANCH"
  echo ""
  exit 0
else
  echo "❌ Invalid branch name: $BRANCH"
  echo "👉 Use GitFlow naming: feature/<name>, hotfix/<name>, etc."
  echo ""
  exit 1
fi