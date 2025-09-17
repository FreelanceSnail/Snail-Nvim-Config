return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			{ "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "File tree" },
		},
		config = function()
			require("nvim-tree").setup({
				git = { enable = true, ignore = false }, -- 旧版字段：不按 .gitignore 隐藏
				filters = {
					dotfiles = false, -- 如需显示点文件
					git_ignored = false, -- 新版字段：不隐藏 .gitignore 项
				},
			})
		end,
	},
}
