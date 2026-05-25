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
			require("mason").setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
			})
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

			vim.lsp.config("roslyn", {
				on_attach = function()
					print("This will run when the server attaches!")
				end,
				settings = {
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
					},
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = true,
					},
				},
			})

			vim.lsp.config.lua_ls = {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},

						diagnostics = {
							-- Add global variables that should not be warned about here
							globals = { "vim", "require", "setup", "love" },

							disable = {
								"duplicate-set-field",
							},
						},

						workspace = {
							-- point to your downloaded LuaCATS definitions
							checkThirdParty = "Apply",

							library = {
								vim.fn.expand("$HOME") .. "/.local/share/LuaAddons/library",
							},
						},
					},
				},
			}

			vim.lsp.config.godotdev = {
				editor_host = "127.0.0.1", -- Godot editor host
				editor_port = 6007, -- Godot LSP port
				debug_port = 6007, -- Godot debugger port
				csharp = true, -- Enable C# Installation Support
				autostart_editor_server = true, -- Enable auto start Nvim server
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

			-- Enables the specified LSP so it can automatically attach when matching filetypes are opened.
			vim.lsp.enable("pyright")
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("gopls")
			vim.lsp.enable("gdscript_lsp")

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
