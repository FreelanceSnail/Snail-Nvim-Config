# Neovim 插件使用说明（Lua / Python / JS-TS / Clojure 配置）

## 🌳 文件树 — nvim-tree
- 打开/关闭文件树：`<Space> e`
- 在树中回车：打开文件
- `a` 新建文件 / `d` 删除 / `r` 重命名
- `yy` 复制路径
- **提示**：已配置“打开文件后自动关闭树”，因此一个 `:q` 就能退出 Neovim

---

## 🖥️ 内置终端 — toggleterm
- 打开/关闭浮动终端：`<Space> t`
- 在终端模式里 `<Space> t` 也能切回
- `<Esc>` 或 `Ctrl + \` Ctrl + n`：从终端回到 Normal 模式

---

## 🔍 模糊搜索 — telescope
- 查找文件：`<Space> ff`
- 全局搜索文本（ripgrep）：`<Space> fg`
- 当前已打开 buffer：`<Space> fb`
- 帮助文档：`<Space> fh`

---

## 🌈 语法高亮 — treesitter
- 自动启用：支持 **Lua / Python / JavaScript / TypeScript / Clojure**
- 提供更精准的语法高亮和缩进
- 更新语法库：`:TSUpdate`

---

## ⚙️ LSP — mason + lspconfig
已配置语言服务器：Lua / Python / TS / Clojure

- 跳转定义：`gd`
- 查找引用：`gr`
- 跳转声明：`gD`
- 查看悬停文档：`K`
- 重命名符号：`<Space> rn`
- 代码动作：`<Space> ca`
- 上一个/下一个诊断：`[d` / `]d`

安装/管理 LSP：
```vim
:Mason
```
进入 Mason 界面后用 `i` 安装，例如 `lua-language-server`、`pyright`、`typescript-language-server`、`clojure-lsp`。

---

## 📑 符号大纲 — symbols-outline
- 打开/关闭大纲：`<Space> so`
- 在侧边栏显示当前 buffer 的函数/变量结构
- 回车：跳转到对应定义

---

## 📊 状态栏 — lualine
- 状态栏会自动显示文件名、模式、位置等信息
- 已启用图标（使用 Nerd Font），若字体缺失会显示乱码

---

## ✍️ 代码补全 — nvim-cmp + LuaSnip
- 触发补全：`Ctrl + Space`
- 确认补全：`Enter`
- 在补全菜单内：`Tab` / `Shift + Tab` 切换选项
- 片段展开：输入触发点后 `Tab`
- 片段跳转：`Tab` 前进，`Shift + Tab` 后退

---

## 🧹 格式化 / 诊断 — none-ls (null-ls)
已配置工具：
- **Lua**：`stylua`
- **Python**：`black`、`isort`
- **JS/TS 等**：`prettierd`
- **Clojure**：`cljfmt`、`clj-kondo`

**使用方式：**
- 保存时自动格式化（Format on Save）
- 手动触发：
  ```vim
  :lua vim.lsp.buf.format()
  ```

---

## 🔑 常用快捷键总览
| 功能             | 快捷键             |
|------------------|--------------------|
| 文件树           | `<Space> e`        |
| 内置终端         | `Ctrl + \``        |
| 搜索文件         | `<Space> ff`       |
| 搜索文本         | `<Space> fg`       |
| 搜索缓冲区       | `<Space> fb`       |
| 搜索帮助         | `<Space> fh`       |
| 符号大纲         | `<Space> so`       |
| LSP 定义         | `gd`               |
| LSP 引用         | `gr`               |
| LSP 悬停         | `K`                |
| LSP 重命名       | `<Space> rn`       |
| LSP 动作         | `<Space> ca`       |
| 诊断导航         | `[d` / `]d`        |
| 触发补全         | `Ctrl + Space`     |
| 确认补全         | `Enter`            |
| 补全切换         | `Tab` / `Shift-Tab`|

---

## ✨ Markdown 预览 — glow.nvim
- 打开/关闭预览：`<Space> g`
- 第一次按：执行 `:Glow`，在 Neovim 内部渲染 Markdown
- 再次按：检测到 Glow buffer 已存在 → 自动关闭
