#!/bin/bash

# Valentine Deployment Script
# Deploys the valentine proposal to GitHub Pages

set -e # Exit on error

echo "🚀 Valentine Deployment Script"
echo "==============================="
echo ""

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
  echo "❌ Error: Not a git repository!"
  echo "Please run 'git init' first."
  exit 1
fi

# Get the remote URL
REMOTE_URL=$(git config --get remote.origin.url 2>/dev/null || echo "")

if [ -z "$REMOTE_URL" ]; then
  echo "❌ Error: No remote origin found!"
  echo "Please add a GitHub remote: git remote add origin <url>"
  exit 1
fi

echo "✅ Repository configured:"
echo "   Remote: $REMOTE_URL"
echo ""

# Check if we have uncommitted changes
if ! git diff-index --quiet HEAD --; then
  echo "📝 Staging changes..."
  git add .
  git commit -m "Valentine proposal template"
fi

echo "🚀 Pushing to GitHub..."
git push -u origin main 2>/dev/null || git push -u origin master 2>/dev/null || {
  echo "❌ Error: Could not push to GitHub"
  exit 1
}

echo ""
echo "✅ Deployment successful!"
echo ""
echo "📖 GitHub Pages Setup Instructions:"
echo "  1. Go to https://github.com/$(echo $REMOTE_URL | sed 's/.*[:/]\(.*\)\/\(.*\)\.git/\1\/\2/')/settings"
echo "  2. Scroll to 'Pages' section"
echo "  3. Under 'Source', select 'Deploy from a branch'"
echo "  4. Select 'main' (or 'master') branch and 'root' folder"
echo "  5. Click 'Save'"
echo ""
echo "Your valentine will be live at:"
echo "  https://$(echo $REMOTE_URL | sed 's/.*[:/]\(.*\)\/\(.*\)\.git/\1.github.io\/\2/')"
echo ""
echo "💖 Happy Valentine's Day!"
