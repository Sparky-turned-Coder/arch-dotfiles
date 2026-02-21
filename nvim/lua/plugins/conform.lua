return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black", "ruff" },
				-- You can customize some of the format options for the filetype (:help conform.format)
				rust = { "rustfmt", lsp_format = "fallback" },
				-- Conform will run the first available formatter
				javascript = { "prettierd", "prettier", stop_after_first = true },
				c = { "clang_format" },
				cpp = { "clang_format" },
				go = { "goimports", "gofumpt" },
				html = { "prettier" },
			},
			format_on_save = {
				timeout_ms = 500,
				async = false,
				lsp_fallback = true, -- If no formatter defined, try LSP
			},
			-- 			vim.api.nvim_create_autocmd("BufWritePre", {
			-- 				pattern = "*",
			-- 				callback = function(args)
			-- 					require("conform").format({ bufnr = args.buf })
			-- 				end,
			-- 			}),
		},
		init = function()
			-- Set up a general keymap for formatting
			vim.api.nvim_create_user_command("Format", function(args)
				require("conform").format({ async = args.fargs, lsp_fallback = true })
			end, { desc = "Format file", nargs = "?" })
		end,
	},
}
