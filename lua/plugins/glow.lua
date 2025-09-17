return {
	{
		"ellisonleao/glow.nvim",
		cmd = "Glow",
		config = true,
		keys = {
			{
				"<leader>g",
				function()
					-- 检查 glow buffer 是否已经存在
					local glow_buf = nil
					for _, buf in ipairs(vim.api.nvim_list_bufs()) do
						if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "glowpreview" then
							glow_buf = buf
							break
						end
					end

					if glow_buf then
						-- 如果已经打开，直接关掉 buffer
						vim.api.nvim_buf_delete(glow_buf, { force = true })
					else
						-- 否则运行 Glow 打开预览
						vim.cmd("Glow")
					end
				end,
				desc = "Toggle Markdown preview (Glow)",
			},
		},
	},
}
