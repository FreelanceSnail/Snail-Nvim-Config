-- 选中复制后高亮提示
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 120 })
	end,
})

-- 当文件树是最后一个buffer时，自动退出nvim
vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		if #vim.api.nvim_list_wins() == 1 and vim.bo.filetype == "NvimTree" then
			vim.cmd("quit")
		end
	end,
})
-- 自定义命令 :HelpUsage 打开 USAGE.md
vim.api.nvim_create_user_command("NvimUsage", function()
	local usage_path = vim.fn.stdpath("config") .. "/NEOVIM_USAGE.md"
	vim.cmd("edit " .. usage_path)
end, { desc = "Open Neovim usage guide" })
