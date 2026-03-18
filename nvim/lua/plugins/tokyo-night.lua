return {
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("tokyonight").setup({
				transparent_background = false,
				styles = {
					comments = { italic = true },
					keywords = { bold = true },
					functions = { italic = true },
				},

				on_colors = function(colors)
					colors.comment = "#565f89"
				end,

				on_highlights = function(highlights, _)
					highlights["@keyword.import.go"] = { fg = "#ff5370", bold = false }
				end,
			})

			vim.cmd("colorscheme tokyonight-moon")
		end,
	},
}
