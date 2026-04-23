return {
  {
    "ellisonleao/glow.nvim",
    cmd = "Glow",
    config = function()
      local glow_path = vim.fn.exepath("glow")
      if glow_path == "" and vim.fn.has("win32") == 1 then
        local matches = vim.fn.glob(
          vim.fn.expand("~/AppData/Local/Microsoft/WinGet/Packages/charmbracelet.glow_*/**/glow.exe"),
          false,
          true
        )
        glow_path = matches[1] or ""
      end

      require("glow").setup({
        glow_path = glow_path ~= "" and glow_path or "glow",
      })
    end,
    keys = {
      {
        "<leader>g",
        function()
          local glow_buf = nil
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "glowpreview" then
              glow_buf = buf
              break
            end
          end

          if glow_buf then
            vim.api.nvim_buf_delete(glow_buf, { force = true })
          else
            vim.cmd("Glow")
          end
        end,
        desc = "Toggle Markdown preview (Glow)",
      },
    },
  },
}
