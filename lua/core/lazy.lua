-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- 统一从 plugins 目录导入所有插件规范
require("lazy").setup({
	rocks = { enabled = false },
	spec = { { import = "plugins" } },
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true }, -- 如需自动检查更新可改为 true
})
