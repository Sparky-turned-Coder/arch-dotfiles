return {
	-- LSP Configuration & Plugins
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				-- Automatically install servers specified here
				ensure_installed = {
					"lua_ls",
					"gopls",
					"clangd",
					"html",
					"tailwindcss",
					"pyright",
					"jdtls",
					"bashls",
					"eslint",
				},
				-- Automatically set up servers
				automatic_installation = true,
			})

			vim.lsp.config.lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							-- Add global variables that should not be warned about here
							globals = { "vim", "require", "setup" },
						},
					},
				},
			}

			-- Set up servers with default config
			--       local lspconfig = require('lspconfig')
			--       require('mason-lspconfig').setup_handlers({
			--         function(server_name)
			--           lspconfig[server_name].setup({})
			--         end,
			--       })
		end,
	},
}
