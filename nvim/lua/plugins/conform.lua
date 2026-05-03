return {
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "black", "isort", "ruff" },
				-- You can customize some of the format options for the filetype (:help conform.format)
				rust = { "rustfmt", lsp_format = "fallback" },
				-- Conform will run the first available formatter
				javascript = { "prettierd", "prettier", stop_after_first = true },
				c = { "clang_format" },
				cpp = { "clang_format" },
				go = { "goimports", "gofumpt" },
				html = { "prettier" },
			},
			formatters = {
				clang_format = {
					-- use prepend_args to append these to default args
					prepend_args = { "-style=P{allowshortfunctionsonasingleline: none}" },
				},
			},
			format_on_save = {
				timeout_ms = 500,
				async = false,
				lsp_fallback = true, -- If no formatter defined, try LSP
			},
		},
	},
}
