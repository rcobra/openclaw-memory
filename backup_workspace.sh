#!/usr/bin/env bash
set -euo pipefail

ROOT="/data/.openclaw/workspace"
cd "$ROOT"

# Initialize repo if needed
if [ ! -d .git ]; then
  git init
  git branch -M main || true
fi

# Commit only if there are changes
if [ -n "$(git status --porcelain)" ]; then
  git add -A
  git commit -m "auto backup: $(date -Is)" --no-gpg-sign || true
  # Push only if remote exists
  if git remote get-url origin >/dev/null 2>&1; then
    git push -u origin main
  fi
fi
