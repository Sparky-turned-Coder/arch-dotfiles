return {
	{ -- Linting
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			-- Enable linters
			lint.linters_by_ft = {
				python = { "ruff" },
			}
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			-- vim.api.nvim_create_user_command("Lint", "lua require("lint").try_lint()", {})
			vim.api.nvim_create_user_command("Lint", function()
				lint.try_lint()
				-- Open quickfix only if there are lint results
				vim.defer_fn(function()
					if #vim.fn.getqflist() > 0 then
						vim.cmd("copen")
					end
				end, 100)
			end, {})

			-- Auto-lint on events
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					-- Only run the linter in buffers that you can modify in order to
					-- avoid superfluous noise, notably within the handy LSP pop-ups that
					-- describe the hovered symbol using Markdown.
					if vim.bo.modifiable then
						lint.try_lint()
					end
				end,
			})
		end,
	},
}
