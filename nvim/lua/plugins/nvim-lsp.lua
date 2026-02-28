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

			vim.lsp.config.gopls = {
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_markers = { "go.mod", "go.sum", "go.work", ".git" },
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = {
							unusedparams = true,
						},
					},
				},
			}

			-- Enable the server (not sure if this is necessary yet)
			vim.lsp.enable("gopls")

			-- Optional: Keymaps and Formatting on Save
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end

					-- Enable semantic tokens (modern, non-deprecated)
					if client.server_capabilities.semanticTokensProvider then
						client.server_capabilities.semanticTokensProvider.full = true
					end

					if client.name == "gopls" then
						-- Format on save
						vim.api.nvim_create_autocmd("BufWritePre", {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
						})
					end
				end,
			})
		end,
	},
}
