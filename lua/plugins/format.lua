return {
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")
      local formatting  = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics

      null_ls.setup({
        sources = {
          -- Lua
          formatting.stylua,
          -- Python
          formatting.black.with({ extra_args = { "--fast" } }),
          formatting.isort,
          -- JS/TS/JSON/MD/CSS/HTML 等
          formatting.prettierd,
          -- Clojure
          diagnostics.clj_kondo,
          formatting.cljfmt,  -- 你安装的
        },
      })

      -- 保存自动格式化
      local aug = vim.api.nvim_create_augroup("FormatOnSave", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = aug,
        callback = function(event)
          local has_null = false
          for _, c in ipairs(vim.lsp.get_active_clients({ bufnr = event.buf })) do
            if c.name == "null-ls" then has_null = true break end
          end
          vim.lsp.buf.format({
            bufnr = event.buf,
            filter = function(client)
              if has_null then return client.name == "null-ls" end
              return true
            end,
            timeout_ms = 2000,
          })
        end,
      })
    end,
  },
}

