#!/usr/bin/env bash
set -euo pipefail

REPO="${REPO:-https://github.com/FreelanceSnail/Snail-Nvim-Config.git}"
NVIM_DIR="${NVIM_DIR:-$HOME/.config/nvim}"
REQUIRED_NVIM="0.10.0"

have_cmd() { command -v "$1" >/dev/null 2>&1; }

ver_ge() {
  # 返回 0 表示 $1 >= $2
  # 利用 sort -V 跨平台比较版本（macOS/Linux 都有）
  local a="$1" b="$2"
  [ "$(printf '%s\n' "$b" "$a" | sort -V | head -n1)" = "$b" ]
}

echo "[1/6] 安装基础依赖..."
if have_cmd apt; then
  sudo apt update
  sudo apt install -y git curl ripgrep fd-find universal-ctags neovim
  # 统一 fd 命令名（Ubuntu 下叫 fdfind）
  if have_cmd fdfind; then
    sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd
  fi
elif have_cmd brew; then
  brew update
  brew install git curl ripgrep fd universal-ctags neovim
else
  echo "未检测到 apt 或 brew，请手动安装 git/curl/rg/fd/ctags/neovim 后重试。" >&2
  exit 1
fi

echo "[2/6] 检查 Neovim 版本..."
if ! have_cmd nvim; then
  echo "未找到 nvim，可执行文件未安装或 PATH 未配置。" >&2
  exit 1
fi

NVIM_VER_RAW="$(nvim --version | head -n1 | sed -E 's/.*v([0-9]+\.[0-9]+\.[0-9]+).*/\1/')"
NVIM_VER="${NVIM_VER_RAW:-0.0.0}"
echo "检测到 nvim 版本: $NVIM_VER (需要 >= $REQUIRED_NVIM)"

if ! ver_ge "$NVIM_VER" "$REQUIRED_NVIM"; then
  echo "Neovim 版本过低，请在Github上下载最新的Neovim Appimage，添加可执行权限，并移动到/usr/local/bin/nvim。"
fi

echo "[3/6] 克隆/更新 nvim 配置..."
if [ -d "$NVIM_DIR/.git" ]; then
  git -C "$NVIM_DIR" pull --rebase
else
  rm -rf "$NVIM_DIR"
  git clone "$REPO" "$NVIM_DIR"
fi

echo "[4/6] 同步插件（lazy）..."
# 单次 headless 同步，若首次装插件，lazy 会自动完成下载
nvim --headless "+Lazy! sync" "+qa"

echo "[5/6] Treesitter 语法高亮安装/更新（headless-safe）..."
# 使用 Lua API，避免在 headless + 懒加载下 :TSUpdateSync 未注册的问题
nvim --headless +"lua \
  local ok,inst = pcall(require,'nvim-treesitter.install'); \
  if ok then inst.update({with_sync=true})(); else print('nvim-treesitter 未就绪'); end" +qa

echo "[6/6] 用 Mason 安装 LSP/格式化器..."
# 先确保 mason 已加载，再执行 MasonInstall（若已安装会跳过）
nvim --headless +"lua \
  local ok = pcall(require,'mason'); \
  if ok then \
    vim.cmd([[MasonInstall \
      lua-language-server pyright typescript-language-server clojure-lsp \
      stylua black isort prettierd clj-kondo]]); \
  else \
    print('mason 未就绪（可能由懒加载触发条件限制），将由首次启动时自动安装'); \
  end" +qa

echo "✅ 安装完成。首次启动 nvim 时会自动加载你的配置。"
