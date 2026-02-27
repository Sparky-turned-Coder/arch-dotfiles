return {
	-- the colorscheme should be available when starting Neovim
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("tokyonight").setup({
				style = "storm",
				light_style = "day",
				transparent_background = false,
				styles = {
					comments = { italic = true },
					keywords = { bold = true },
					functions = { italic = true },
					variables = {},
				},
				on_colors = function(colors)
					colors.comment = "#565f89"
				end,
				on_highlights = function(hl, _)
					-- 					-- Go-specific highlights
					hl["@keyword.import.go"] = { fg = "#ff5370", bold = false } -- package, import, func, etc.
					-- 					hl["@variable.go"] = { fg = "#b3f0ff" } -- light blue
					-- 					hl["@variable.parameter.go"] = { fg = "#e0af68" } -- yellow
					-- 					hl["@constant.go"] = { fg = "#ff9e64" } -- orange
					-- 					hl["@number.go"] = { fg = "#9df2d4" }
					-- 					hl["@string.go"] = { fg = "#ff9e64" } -- orange
					-- 					hl["@keyword.function.go"] = { fg = "#0e4a8c", italic = true } -- blue
					-- 					hl["@function.go"] = { fg = "#faf052" } -- yellow
					-- 					hl["function.method.call.go"] = { fg = "#faf052" }
					-- 					hl["property.go"] = { fg = "#faf052" }
				end,
			})
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
}
