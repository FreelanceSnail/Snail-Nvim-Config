return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			pcall(function()
				capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			end)

			local on_attach = function(_, bufnr)
				local o = { buffer = bufnr }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, o)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, o)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, o)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, o)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, o)
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, o)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, o)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, o)
			end

			vim.lsp.config("lua_ls", {
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			})

			vim.lsp.config("pyright", { on_attach = on_attach, capabilities = capabilities })
			vim.lsp.config("ts_ls", { on_attach = on_attach, capabilities = capabilities })
			vim.lsp.config("clojure_lsp", { on_attach = on_attach, capabilities = capabilities })

			vim.lsp.enable({ "lua_ls", "pyright", "ts_ls", "clojure_lsp" })

			-- 提示：在 :Mason 安装：
			-- lua-language-server, pyright, typescript-language-server, clojure-lsp
		end,
	},
}
