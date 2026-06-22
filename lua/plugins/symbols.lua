return {
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { "AerialToggle" },
    keys = {
      { "<leader>so", "<cmd>AerialToggle!<CR>", desc = "Symbols outline" },
    },
    config = function()
      require("aerial").setup({
        layout = {
          max_width = { 40, 0.3 },
          width = nil,
          min_width = 20,
        },
        attach_mode = "global",
        show_guides = true,
      })
    end,
  },
}
