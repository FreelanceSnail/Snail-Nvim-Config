return {
{
"simrat39/symbols-outline.nvim",
cmd = "SymbolsOutline",
keys = {
{ "<leader>so", "<cmd>SymbolsOutline<CR>", desc = "Symbols outline" },
},
config = function()
require("symbols-outline").setup({})
end,
},
}
