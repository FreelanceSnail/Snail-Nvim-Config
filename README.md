# Snail Neovim 配置

## 介绍

花了一个晚上用ChatGPT帮我配置的支持Lua/Python/JS-TS/Clojure的Neovim插件配置。

拥有的功能如下：

- 文件树
- 随时可呼出的终端
- 语法检查和自动格式化
- 语法补全
- 文件和内容搜索
- 随时可呼出的Markdown文件预览
- 可随时使用`:NvimUsage`查看的使用手册

## 一键安装脚本

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/FreelanceSnail/Snail-Nvim-Config/main/install.sh)"
```

## Linux / macOS 手动安装

```bash
git clone https://github.com/FreelanceSnail/Snail-Nvim-Config.git ~/.config/nvim
```

首次启动 Neovim 后执行：

```vim
:Lazy sync
:MasonInstall lua-language-server pyright typescript-language-server clojure-lsp stylua black isort prettierd clj-kondo cljfmt
:TSInstall lua python javascript typescript clojure
```

> 由于 nvim-treesitter v1.0+ 不再支持 `ensure_installed` 自动安装，parser 需要手动通过 `:TSInstall` 安装。

## Windows 安装

先安装 Neovim 和外部命令行依赖：

```powershell
winget install --id Neovim.Neovim -e
winget install --id tree-sitter.tree-sitter-cli -e
winget install --id BurntSushi.ripgrep.MSVC -e
winget install --id sharkdp.fd -e
winget install --id BrechtSanders.WinLibs.POSIX.UCRT -e
winget install --id charmbracelet.glow -e
```

把本仓库内容放到 Neovim 的 Windows 配置目录：

```powershell
git clone https://github.com/FreelanceSnail/Snail-Nvim-Config.git "$env:LOCALAPPDATA\nvim"
```

首次启动后同步插件、Mason 工具和 Treesitter parser：

```vim
:Lazy sync
:MasonInstall lua-language-server pyright typescript-language-server clojure-lsp stylua black isort prettierd clj-kondo cljfmt
:TSInstall lua python javascript typescript clojure
```

> 由于 nvim-treesitter v1.0+ 不再支持 `ensure_installed` 自动安装，parser 需要手动通过 `:TSInstall` 安装。

不要把这些本机生成目录提交进仓库：

- `%LOCALAPPDATA%\nvim-data`
- lazy.nvim 下载的插件目录
- Mason 安装目录
- Treesitter 编译生成的 parser 文件
