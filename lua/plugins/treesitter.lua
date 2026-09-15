return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local languages = { "lua", "python", "javascript", "typescript", "rust", "clojure", "commonlisp", "markdown", "markdown_inline" }

      local ok, treesitter = pcall(require, "nvim-treesitter")
      if ok and treesitter.setup then
        treesitter.setup({
          install_dir = vim.fn.stdpath("data") .. "/site",
        })
      end

      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if ok then
        configs.setup({
          ensure_installed = languages,
          highlight = { enable = true },
          indent = { enable = true },
        })
        return
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function(event)
          pcall(vim.treesitter.start, event.buf)
          vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
}
