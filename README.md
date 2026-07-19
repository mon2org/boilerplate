# boilerplate

このリポジトリは、ローカル開発に加えて Dev Container と GitHub Codespaces でも同じように扱えることを前提にしている。

## Dev Container / Codespaces

- `.devcontainer/scripts/` 配下に、Dev Container のライフサイクル名に対応した `*.sh` スクリプトを置きます。
- スクリプトは Dev Container から呼び出すだけにして、具体的な処理はなるべく `scripts/` 側に閉じます。
- `mise` はコンテナ起動時点で利用できる状態にし、どのシェルからでも `mise` コマンド自体が見えるようにします。

## 想定構成

- `.devcontainer/scripts/on-create.sh`
- `.devcontainer/scripts/post-create.sh`
- `.devcontainer/scripts/post-start.sh`
- `.devcontainer/scripts/update-content.sh`