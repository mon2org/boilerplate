#!/usr/bin/env bash
set -e

echo "Configuring GitHub repository settings for ${GITHUB_REPOSITORY}..."

# GitHub CLI を使用して、新設されたリポジトリの初期設定を自動化します。
# プロジェクトに合わせて不要な機能を false に、必要なものを true に調整してください。
gh repo edit "${GITHUB_REPOSITORY}" \
  --delete-branch-on-merge=true \
  --enable-issues=true \
  --enable-wiki=false \
  --enable-projects=false

echo "Repository configuration completed successfully."