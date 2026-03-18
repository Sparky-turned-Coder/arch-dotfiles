return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site/parser",
			-- A list of parser names, or "all"
			ensure_installed = { "lua", "python" },

			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = true,

			-- Automatically install missing parsers when entering buffer
			auto_install = true,

			highlight = {
				enable = true, -- Enable highlighting
				additional_vim_regex_highlighting = { "markdown" },
			},
			indent = {
				enable = true,
				-- disable = { "python" },
			}, -- Enable indentation
		})
	end,
}
