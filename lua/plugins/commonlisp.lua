return {
  {
    "vlime/vlime",
    ft = { "lisp", "commonlisp" },
    config = function()
      -- 启用自动文档与包名显示
      vim.g.vlime_enable_autodoc = 1
      vim.g.vlime_show_package = 1

      -- 识别 asd 系统定义文件为 lisp 类型
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.asd", "*.lisp", "*.lsp", "*.cl" },
        callback = function()
          vim.bo.filetype = "lisp"
        end,
      })

      -- 自定义快捷键
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>rr", "<cmd>VlimeConnect<CR>", vim.tbl_extend("force", opts, { desc = "Connect to SWANK" }))
      vim.keymap.set("n", "<leader>rf", "<cmd>VlimeLoadFile<CR>", vim.tbl_extend("force", opts, { desc = "Load current Lisp file" }))
      vim.keymap.set("n", "<leader>rq", "<cmd>VlimeClose<CR>", vim.tbl_extend("force", opts, { desc = "Close SWANK connection" }))
    end,
  },
}
