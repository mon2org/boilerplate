# boilerplate

このリポジトリは、ローカル開発に加えて Dev Container と GitHub Codespaces でも同じように扱えることを前提にしている。

## 🚀 ゼロ・コンフィギュレーション（Ready to Dev）

このリポジトリは、テンプレートから作成された瞬間、およびコンテナが起動した瞬間に、すべての開発環境構築が全自動で完了するように設計されている。

### 1. リポジトリ作成時の自動初期化（GitHub Actions）
新しくリポジトリが作成（最初のプッシュ）されると、GitHub Actions（Bootstrap）が起動し、以下の処理をバックグラウンドで実行したのち、自身を完全に削除（自己クリーンアップ）する。
- GitHub CLI (`gh repo edit`) によるリポジトリ機能設定の最適化
- テンプレートからの初期Issue自動起票 (`gh issue create`)
- プロジェクト固有の `README.md` の動的生成

### 2. コンテナ起動時の自動セットアップ（Dev Container / Codespaces）
`.devcontainer/scripts/` 配下に、Dev Container のライフサイクル名に対応した `*.sh` スクリプトを配置し、環境構築のロジックをカプセル化している。

特に `post-create.sh` では以下の自動化を行っている。
- **ランタイム自動構築**: `.config/mise.toml` を自動検知し、`mise install` で開発に必要なツールをすべて一括インストール。
- **パスの自動解決**: コンテナ内の `~/.zshrc` へ `mise activate zsh` を自動追記し、シェル起動時に即座にコマンド（`lefthook` 等）が使える状態を担保。
- **Gitフック自動登録**: `mise exec` 経由で安全に `lefthook install` を実行し、コミット前の検証環境を強制的に構築。

### 3. チーム開発時のGitフック自動同期（Lefthook）
`lefthook.toml` の `post-merge` フック機能により、`git pull` や `git merge` を行った際に `lefthook` フォルダ内や設定ファイルに更新があれば、ローカル環境でも自動的に `lefthook install` が再実行される。これにより、チーム間でのGitフックの乖離を防ぐ。

---

## 📂 想定ディレクトリ構成

```text
.
├── .config/
│   └── mise.toml              # 開発ツール・ランタイムの一元管理
├── .devcontainer/
│   └── scripts/               # Dev Container ライフサイクルスクリプト
│       ├── on-create.sh
│       ├── post-create.sh     # mise自動適用 / zshパス通し / lefthook登録
│       ├── post-start.sh
│       └── update-content.sh
├── .github/
│   ├── script/                # 初回セットアップ用スクリプト（完了後自動消去）
│   └── workflows/
│       └── bootstrap.yml      # 初回自動初期化ワークフロー（完了後自動消去）
└── lefthook.toml              # Gitフック構成（pull時の自動インストール設定を含む）
```