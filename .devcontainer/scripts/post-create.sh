#!/bin/sh
set -eu

printf '%s\n' "[devcontainer] post-create"

# .config/mise.toml も検知できるように条件を追加
if [ -f .config/mise.toml ] || [ -f .mise.toml ] || [ -f .tool-versions ]; then
  
  # コンテナの再ビルド（Rebuild）時に ~/.zshrc へ何度も同じ設定が追記されるのを防ぐガード
  # （すでに記述がある場合は追記しない、なければ追記する）
  if [ -f ~/.zshrc ]; then
    if ! grep -q 'mise activate zsh' ~/.zshrc; then
      echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
    fi
  else
    echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
  fi

  # ツールのインストールとフックの設定
  mise install
  mise exec -- lefthook install
fi