#!/usr/bin/env bash
set -e

REPO="${REPO:-https://github.com/<你的用户名>/nvim-config.git}"
NVIM_DIR="${NVIM_DIR:-$HOME/.config/nvim}"

echo "[1/5] 安装基础依赖..."
if command -v apt >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y git curl ripgrep fd-find universal-ctags neovim
  # 统一 fd 命令名（Ubuntu 下叫 fdfind）
  if command -v fdfind >/dev/null; then sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd; fi
elif command -v brew >/dev/null 2>&1; then
  brew update
  brew install git curl ripgrep fd universal-ctags neovim
else
  echo "未检测到 apt 或 brew，请手动安装 git/curl/rg/fd/ctags/neovim 后重试。" >&2
  exit 1
fi

echo "[2/5] 克隆/更新 nvim 配置..."
if [ -d "$NVIM_DIR/.git" ]; then
  git -C "$NVIM_DIR" pull --rebase
else
  rm -rf "$NVIM_DIR"
  git clone "$REPO" "$NVIM_DIR"
fi

echo "[3/5] 运行 Neovim 同步插件（lazy）..."
nvim --headless "+Lazy! sync" "+qa"

echo "[4/5] Treesitter 语法安装/更新..."
nvim --headless "+TSUpdateSync lua python javascript typescript clojure" "+qa"

echo "[5/5] 用 Mason 安装 LSP/格式化器..."
nvim --headless "+MasonInstall lua-language-server pyright typescript-language-server clojure-lsp stylua black isort prettierd clj-kondo" "+qa"

echo "✅ 安装完成。首次启动 nvim 时会自动加载你的配置。"

