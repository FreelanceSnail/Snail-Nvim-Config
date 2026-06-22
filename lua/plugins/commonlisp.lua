return {
  {
    "vlime/vlime",
    ft = { "lisp", "commonlisp" },
    init = function(plugin)
      -- vlime 的 Vim 插件文件位于仓库的 vim/ 子目录
      vim.opt.rtp:append(plugin.dir .. "/vim")
      -- 让 vlime 的默认快捷键也使用 <Space> 作为前缀
      vim.g.vlime_leader = "<leader>"
    end,
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

      -- 自定义便捷快捷键（vlime 默认用 <LocalLeader>，上面已改为 <leader>）
      local opts = { noremap = true, silent = true, buffer = true }
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lisp" },
        callback = function()
          vim.keymap.set("n", "<leader>rr", ":call vlime#plugin#ConnectREPL()<CR>", vim.tbl_extend("force", opts, { desc = "Connect to SWANK" }))
          vim.keymap.set("n", "<leader>rf", ":call vlime#plugin#CompileFile(expand('%:p'))<CR>", vim.tbl_extend("force", opts, { desc = "Compile current Lisp file" }))
          vim.keymap.set("n", "<leader>rq", ":call vlime#plugin#CloseCurConnection()<CR>", vim.tbl_extend("force", opts, { desc = "Close SWANK connection" }))
          vim.keymap.set("n", "<leader>re", ":call vlime#plugin#SendToREPL(vlime#ui#CurTopExpr())<CR>", vim.tbl_extend("force", opts, { desc = "Send top expr to REPL" }))
        end,
      })
    end,
  },
}
