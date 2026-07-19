---
applyTo: ".github/workflows/**"
---

# Context: GitHub Actions CI/CD

## 🤖 自動化・非対話モードの徹底
- ワークフロー内で実行するコマンドやスクリプトは、ユーザー入力を求めない（対話プロンプトが発生しない）完全自動化されたオプションを指定してください。

## 🔐 セキュリティ & トークン
- リポジトリやIssueへの操作を行うステップでは、明示的に `env:` ブロックで `GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}` を渡す構造にしてください。
- ワークフローの冒頭で `permissions:` を最小権限（Least Privilege）の原則に基づいて明示的に定義してください（例: `contents: write`, `issues: write`）。