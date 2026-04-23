-- Let Neovim find global executables installed by nvm on Unix-like systems.
if vim.fn.has("win32") == 0 then
  vim.env.PATH = "/home/lvxj/.nvm/versions/node/v22.17.0/bin:" .. vim.env.PATH
elseif vim.fn.executable("gcc") == 1 then
  vim.env.CC = "gcc"
  vim.env.CXX = "g++"
end

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
