-- Let Neovim find global executables installed by nvm on Unix-like systems.
if vim.fn.has("win32") == 0 then
  local nvm_dir = vim.env.HOME .. "/.nvm"
  local nvm_sh = nvm_dir .. "/nvm.sh"
  if vim.fn.filereadable(nvm_sh) == 1 then
    local nvm_path = vim.fn.system({
      "bash",
      "-c",
      "export NVM_DIR=" .. nvm_dir .. " && source " .. nvm_sh .. " && echo $PATH",
    })
    nvm_path = nvm_path:gsub("%s+$", "")
    if nvm_path ~= "" then
      vim.env.PATH = nvm_path
    end
  end
end

if vim.fn.executable("gcc") == 1 then
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
