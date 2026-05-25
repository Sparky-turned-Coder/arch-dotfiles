-- Custom modifications to specific filetypes

vim.filetype.add({
	extension = {
		gotmpl = "gotmpl", -- Or 'go'/'hmtl' depending on template usage
		gowork = "go", -- Treat .gowork as Go
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.treesitter.start()
		vim.bo.indentexpr = ""
		vim.bo.autoindent = true
		vim.bo.smartindent = true -- or true depending on your preference
	end,
})

vim.cmd("filetype plugin indent on")

-- Link semantic tokens to Treesitter or default groups

-- This didn't work

-- vim.cmd([[
--   hi! link @lsp.type.variable @variable
--   hi! link @lsp.typemod.variable.defaultlibrary @variable
--   hi! link @lsp.mod.defaultlibrary @variable
-- ]])
