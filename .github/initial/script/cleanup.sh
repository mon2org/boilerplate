#!/usr/bin/env bash
set -e

git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"
echo "Removing bootstrap files from ${GITHUB_REF_NAME}"

if [ -f .github/README.md ]; then
  git add .github/README.md
fi

git rm --ignore-unmatch README.md
git rm -r --ignore-unmatch .github/initial
git rm --ignore-unmatch .github/workflows/bootstrap.yml
git commit -m "chore: complete bootstrap initialization" || exit 0
git push origin HEAD:${GITHUB_REF_NAME}