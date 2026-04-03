--====================
--    Vague nvim
--====================
return {
	{
		"vague-theme/vague.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other plugins
		config = function()
			require("vague").setup({
				-- Don't set background
				transparent = false,
				-- Disable bold/italic globally
				bold = true,
				italic = true,

				-- Override highlights or add new highlights
				-- on_highlights = function(hl, colors)
				--  -- For available options see `:h nvim_set_hl()`
				-- 	hl.NewHighlight = { fg = colors.fg, bg = colors.bg, bold = true }
				-- 	hl.ExistingHighlight.fg = colors.delta -- only overwrite fg
				-- end,

				-- Override colors
				colors = {
					bg = "#141415",
					inactiveBg = "#1c1c24",
					fg = "#cdcdcd",
					floatBorder = "#878787",
					line = "#252530",
					comment = "#606079",
					builtin = "#b4d4cf",
					func = "#c48282",
					string = "#e8b589",
					number = "#e0a363",
					property = "#c3c3d5",
					constant = "#aeaed1",
					parameter = "#bb9dbd",
					visual = "#333738",
					error = "#d8647e",
					warning = "#f3be7c",
					hint = "#7e98e8",
					operator = "#90a0b5",
					keyword = "#6e94b2",
					type = "#9bb4bc",
					search = "#405065",
					plus = "#7fa563",
					delta = "#f3be7c",
				},
				-- optional configuration here
			})
			vim.cmd("colorscheme vague")
		end,
	},
}

--=====================
--    Tokyo Night
--=====================
--return {
--	{
--		"folke/tokyonight.nvim",
--		lazy = false, -- make sure we load this during startup if it is your main colorscheme
--		priority = 1000, -- make sure to load this before all the other start plugins
--		config = function()
--			require("tokyonight").setup({
--				transparent_background = false,
--				styles = {
--					comments = { italic = true },
--					keywords = { bold = true },
--					functions = { italic = true },
--				},
--
--				on_colors = function(colors)
--					colors.comment = "#565f89"
--				end,
--
--				on_highlights = function(highlights, _)
--					highlights["@keyword.import.go"] = { fg = "#ff5370", bold = false }
--				end,
--			})
--
--			vim.cmd("colorscheme tokyonight-moon")
--		end,
--	},
--}

--====================
--      Gruvbox
--====================
-- return {
-- 	{
-- 		"ellisonleao/gruvbox.nvim",
-- 		priority = 1000,
-- 		config = function()
-- 			require("gruvbox").setup({
-- 				terminal_colors = true, -- add neovim terminal colors
-- 				undercurl = true,
-- 				underline = true,
-- 				bold = true,
-- 				italic = {
-- 					strings = true,
-- 					emphasis = true,
-- 					comments = true,
-- 					operators = false,
-- 					folds = true,
-- 				},
-- 				strikethrough = true,
-- 				invert_selection = false,
-- 				invert_signs = false,
-- 				invert_tabline = false,
-- 				inverse = true, -- invert background for search, diffs, statuslines and errors
-- 				contrast = "hard", -- can be "hard", "soft" or empty string
-- 				palette_overrides = {},
-- 				overrides = {},
-- 				dim_inactive = false,
-- 				transparent_mode = false,
-- 			})
-- 			vim.cmd("colorscheme gruvbox")
-- 		end,
-- 	},
-- }

--===================
--    Catppuccin
--===================
--return {
--	{
--		"catppuccin/nvim",
--		name = "catppuccin",
--		priority = 1000,
--		config = function()
--			require("catppuccin").setup({
--				flavour = "auto", -- latte, frappe, macchiato, mocha
--				background = { -- :h background
--					light = "latte",
--					dark = "mocha",
--				},
--				transparent_background = false, -- disables setting the background color.
--				float = {
--					transparent = false, -- enable transparent floating windows
--					solid = false, -- use solid styling for floating windows, see |winborder|
--				},
--				term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
--				dim_inactive = {
--					enabled = false, -- dims the background color of inactive window
--					shade = "dark",
--					percentage = 0.15, -- percentage of the shade to apply to the inactive window
--				},
--				no_italic = false, -- Force no italic
--				no_bold = false, -- Force no bold
--				no_underline = false, -- Force no underline
--				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
--					comments = { "italic" }, -- Change the style of comments
--					conditionals = { "italic" },
--					loops = {},
--					functions = {},
--					keywords = {},
--					strings = {},
--					variables = {},
--					numbers = {},
--					booleans = {},
--					properties = {},
--					types = {},
--					operators = {},
--					-- miscs = {}, -- Uncomment to turn off hard-coded styles
--				},
--				lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
--					virtual_text = {
--						errors = { "italic" },
--						hints = { "italic" },
--						warnings = { "italic" },
--						information = { "italic" },
--						ok = { "italic" },
--					},
--					underlines = {
--						errors = { "underline" },
--						hints = { "underline" },
--						warnings = { "underline" },
--						information = { "underline" },
--						ok = { "underline" },
--					},
--					inlay_hints = {
--						background = true,
--					},
--				},
--				color_overrides = {},
--				custom_highlights = {},
--				default_integrations = true,
--				auto_integrations = false,
--				integrations = {
--					cmp = true,
--					gitsigns = true,
--					nvimtree = true,
--					notify = false,
--					mini = {
--						enabled = true,
--						indentscope_color = "",
--					},
--					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
--				},
--			})
--
--			-- setup must be called before loading
--			vim.cmd.colorscheme("catppuccin-") -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
--		end,
--	},
--}

--===================
--    Nightfox
--===================
-- return {
-- 	{
-- 		"EdenEast/nightfox.nvim",
-- 		priority = 1000,
-- 		config = function()
-- 			-- Default options
-- 			require("nightfox").setup({
-- 				options = {
-- 					-- Compiled file's destination location
-- 					compile_path = vim.fn.stdpath("cache") .. "/nightfox",
-- 					compile_file_suffix = "_compiled", -- Compiled file suffix
-- 					transparent = false, -- Disable setting background
-- 					terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
-- 					dim_inactive = false, -- Non focused panes set to alternative background
-- 					module_default = true, -- Default enable value for modules
-- 					colorblind = {
-- 						enable = false, -- Enable colorblind support
-- 						simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
-- 						severity = {
-- 							protan = 0, -- Severity [0,1] for protan (red)
-- 							deutan = 0, -- Severity [0,1] for deutan (green)
-- 							tritan = 0, -- Severity [0,1] for tritan (blue)
-- 						},
-- 					},
-- 					styles = { -- Style to be applied to different syntax groups
-- 						comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
-- 						conditionals = "NONE",
-- 						constants = "NONE",
-- 						functions = "NONE",
-- 						keywords = "NONE",
-- 						numbers = "NONE",
-- 						operators = "NONE",
-- 						strings = "NONE",
-- 						types = "NONE",
-- 						variables = "NONE",
-- 					},
-- 					inverse = { -- Inverse highlight for different types
-- 						match_paren = false,
-- 						visual = false,
-- 						search = false,
-- 					},
-- 					modules = { -- List of various plugins and additional options
-- 						-- ...
-- 					},
-- 				},
-- 				palettes = {},
-- 				specs = {},
-- 				groups = {},
-- 			})
--
-- 			-- setup must be called before loading
-- 			vim.cmd("colorscheme nightfox")
-- 		end,
-- 	},
-- }
