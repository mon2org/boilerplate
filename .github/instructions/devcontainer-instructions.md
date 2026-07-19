---
applyTo: ".devcontainer/**"
---

# Context: Dev Container & Local Development Environment

## 🛠️ ツールチェーン（mise / lefthook）の優先
- 開発ランタイムの追加やツールのインストールを求められた場合は、独自のインストールコマンドではなく、`.config/mise.toml` への追記、または `mise install` を利用した方法を提案してください。
- 起動スクリプト内で `lefthook` コマンドを叩く際は、パスが通っていない可能性を考慮し、`mise exec -- lefthook install` のように `mise exec` を経由させてください。

## 🔄 冪等性（Idempotency）の確保
- `~/.zshrc` や `~/.bashrc` などの設定ファイルに環境変数を追記するスクリプトを生成する際は、`grep` 等を用いて「既に記述がある場合は追記しない」という二重追記防止用のガード（冪等性）を必ず含めてください。