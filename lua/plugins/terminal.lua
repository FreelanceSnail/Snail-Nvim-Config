return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{
				"<leader>t",
				function()
					require("toggleterm").toggle()
				end,
				mode = { "n", "t" },
				desc = "Toggle terminal",
			},
		},
		config = function()
			require("toggleterm").setup({
				direction = "float",
				open_mapping = [[<leader>t]],
				size = 15,
			})
		end,
	},
}
