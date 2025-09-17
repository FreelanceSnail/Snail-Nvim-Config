-- 让 Neovim 能找到 nvm 的全局可执行文件
vim.env.PATH = "/home/lvxj/.nvm/versions/node/v22.17.0/bin:" .. vim.env.PATH

-- 基础选项
local o = vim.opt

vim.g.mapleader = " "

o.number = true
o.relativenumber = false
o.termguicolors = true

o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true

o.ignorecase = true
o.smartcase = true

o.signcolumn = "yes"
o.scrolloff = 4

-- 更快的渲染与交互体验
o.updatetime = 250
