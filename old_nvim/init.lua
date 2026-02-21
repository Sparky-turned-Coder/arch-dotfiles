vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.swapfile = false
vim.opt.showmode = false
vim.opt.undofile = true
vim.opt.breakindent = true
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true
vim.opt.confirm = true
vim.opt.scrolloff = 12
vim.opt.winborder = "rounded"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.g.have_nerd_font = true

-- Vim Keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
--vim.keymap.set("n", "<C-k>", "<C-w>k")
--vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal insert mode" })
vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>")
vim.keymap.set("n", "<leader>pv", ":Explore<CR>")
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>pf", ":Pick files<CR>", { desc = "Pick files" })
vim.keymap.set("n", "<leader>pb", ":Pick buffers<CR>", { desc = "Pick buffers" })
vim.keymap.set("n", "<leader>pg", ":Pick grep_live<CR>", { desc = "Pick grep (search in files)" })
vim.keymap.set("n", "<leader>ph", ":Pick help<CR>", { desc = "Pick help tags" })
vim.keymap.set("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close all other buffers" })
vim.keymap.set("n", "<leader>a", ":wqa<CR>", { desc = "save and quit all" })

-- Highlight when yanking text
-- See >> :help vim.hl.on_yank()
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight text when yanking (copying)",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- No longer automatically comments out the next line following a comment
vim.api.nvim_create_autocmd("Filetype", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	"NMAC427/guess-indent.nvim", -- Detect tabstop and shiftwidth automatically
	-- Colorscheme
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- load before other plugins
		config = function()
			require("catppuccin").setup()
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.config").setup({
				ensure_installed = {
					"lua",
					"python",
					"markdown",
					"markdown_inline",
					"javascript",
					"typescript",
					"html",
					"css",
					"c",
					"c++",
					"bash",
					"go",
				},
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- Mason (LSP installer)
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason-lspconfig (bridge)
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"pyright", -- Python
					"lua_ls", -- Lua
					"ts_ls", -- Typescript/Javascript
					"marksman", -- Markdown
					"html", -- HTML
					"cssls", -- CSS
					"clangd", -- C/C++
					"bashls", -- bash
					"gopls", -- golang
				},
			})
		end,
	},

	-- Mason tool-installer
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"black", -- Python formatter
					"prettier", -- JS/TS/HTML/CSS/Markdown formatter
					"stylua", -- Lua formatter
					"shfmt", -- bash formatter
					"ruff", -- Python linter
					"golangci-lint", -- go
				},
			})
		end,
	},

	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = function()
			require("go").setup(opts)
			local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require("go.format").goimports()
				end,
				group = format_sync_grp,
			})
			return {
				-- lsp_keymaps = false,
				-- other options
			}
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				markdown = { "prettier" },
				-- Conform can also run multiple formatters sequentially
				-- python = { 'isort', 'black' },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},

	-- 	{ -- Autocompletion
	-- 		"saghen/blink.cmp",
	-- 		event = "VimEnter",
	-- 		version = "1.*",
	-- 		dependencies = {
	-- 			-- Snippet Engine
	-- 			{
	-- 				"L3MON4D3/LuaSnip",
	-- 				version = "2.*",
	-- 				build = (function()
	-- 					-- Build Step is needed for regex support in snippets.
	-- 					-- This step is not supported in many windows environments.
	-- 					-- Remove the below condition to re-enable on windows.
	-- 					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
	-- 						return
	-- 					end
	-- 					return "make install_jsregexp"
	-- 				end)(),
	-- 				dependencies = {
	-- 					-- `friendly-snippets` contains a variety of premade snippets.
	-- 					--    See the README about individual language/framework/plugin snippets:
	-- 					--    https://github.com/rafamadriz/friendly-snippets
	-- 					-- {
	-- 					--   'rafamadriz/friendly-snippets',
	-- 					--   config = function()
	-- 					--     require('luasnip.loaders.from_vscode').lazy_load()
	-- 					--   end,
	-- 					-- },
	-- 				},
	-- 				opts = {},
	-- 			},
	-- 			"folke/lazydev.nvim",
	-- 		},
	--
	-- 		-- module 'blink.cmp'
	-- 		-- type blink.cmp.Config
	-- 		opts = {
	-- 			keymap = {
	-- 				-- 'default' (recommended) for mappings similar to built-in completions
	-- 				--   <c-y> to accept ([y]es) the completion.
	-- 				--    This will auto-import if your LSP supports it.
	-- 				--    This will expand snippets if the LSP sent a snippet.
	-- 				-- 'super-tab' for tab to accept
	-- 				-- 'enter' for enter to accept
	-- 				-- 'none' for no mappings
	-- 				--
	-- 				-- For an understanding of why the 'default' preset is recommended,
	-- 				-- you will need to read `:help ins-completion`
	-- 				--
	-- 				-- No, but seriously. Please read `:help ins-completion`, it is really good!
	-- 				--
	-- 				-- All presets have the following mappings:
	-- 				-- <tab>/<s-tab>: move to right/left of your snippet expansion
	-- 				-- <c-space>: Open menu or open docs if already open
	-- 				-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
	-- 				-- <c-e>: Hide menu
	-- 				-- <c-k>: Toggle signature help
	-- 				--
	-- 				-- See :h blink-cmp-config-keymap for defining your own keymap
	-- 				preset = "default",
	--
	-- 				-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
	-- 				--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
	-- 			},
	--
	-- 			appearance = {
	-- 				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
	-- 				-- Adjusts spacing to ensure icons are aligned
	-- 				nerd_font_variant = "mono",
	-- 			},
	--
	-- 			completion = {
	-- 				-- By default, you may press `<c-space>` to show the documentation.
	-- 				-- Optionally, set `auto_show = true` to show the documentation after a delay.
	-- 				documentation = { auto_show = false, auto_show_delay_ms = 500 },
	-- 			},
	--
	-- 			sources = {
	-- 				default = { "lsp", "path", "snippets", "lazydev" },
	-- 				providers = {
	-- 					lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
	-- 				},
	-- 			},
	--
	-- 			snippets = { preset = "luasnip" },
	--
	-- 			-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
	-- 			-- which automatically downloads a prebuilt binary when enabled.
	-- 			--
	-- 			-- By default, we use the Lua implementation instead, but you may enable
	-- 			-- the rust implementation via `'prefer_rust_with_warning'`
	-- 			--
	-- 			-- See :h blink-cmp-config-fuzzy for more information
	-- 			fuzzy = { implementation = "lua" },
	--
	-- 			-- Shows a signature help window while you type arguments for a function
	-- 			signature = { enabled = true },
	-- 		},
	-- 	},

	-- Mini.pick (fuzzy finder)
	{
		"echasnovski/mini.pick",
		config = function()
			require("mini.pick").setup({
				mappings = {
					move_down = "<C-j>",
					move_up = "<C-k>",
				},
			})
		end,
	},

	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		opts = {
			-- delay between pressing a key and opening which-key (milliseconds)
			-- this setting is independent of vim.o.timeoutlen
			delay = 0,
			icons = {
				-- set icon mappings to true if you have a Nerd Font
				mappings = vim.g.have_nerd_font,
				-- If you are using a Nerd Font: set icons.keys to an empty table which will use the
				-- default which-key.nvim defined Nerd Font icons, otherwise define a string table
				keys = vim.g.have_nerd_font and {} or {
					Up = "<Up> ",
					Down = "<Down> ",
					Left = "<Left> ",
					Right = "<Right> ",
					C = "<C-…> ",
					M = "<M-…> ",
					D = "<D-…> ",
					S = "<S-…> ",
					CR = "<CR> ",
					Esc = "<Esc> ",
					ScrollWheelDown = "<ScrollWheelDown> ",
					ScrollWheelUp = "<ScrollWheelUp> ",
					NL = "<NL> ",
					BS = "<BS> ",
					Space = "<Space> ",
					Tab = "<Tab> ",
					F1 = "<F1>",
					F2 = "<F2>",
					F3 = "<F3>",
					F4 = "<F4>",
					F5 = "<F5>",
					F6 = "<F6>",
					F7 = "<F7>",
					F8 = "<F8>",
					F9 = "<F9>",
					F10 = "<F10>",
					F11 = "<F11>",
					F12 = "<F12>",
				},
			},
		},
	},

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{ import = "plugins" }, -- Markdown-preview
})

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>mp", "<cmd>:MarkdownPreview<CR>", { desc = "Markdown Preview" })

local function run_python(focus_terminal)
	local python_cmd = "python3 " .. vim.fn.expand("%") .. "\n"
	local term_buf = nil
	local term_win = nil

	-- Find existing terminal
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == "terminal" then
			term_buf = buf
			term_win = win
			break
		end
	end

	if term_buf then
		local job = vim.b[term_buf].terminal_job_id
		if job then
			vim.fn.chansend(job, "clear\n")
			vim.fn.chansend(job, python_cmd)
			if focus_terminal and term_win then
				vim.api.nvim_set_current_win(term_win)
			end
			return
		end
	end

	-- No terminal exists; create a new split terminal
	vim.cmd("split | terminal")
	term_win = vim.api.nvim_get_current_win()
	term_buf = vim.api.nvim_get_current_buf()

	-- Keep buffer around when hidden
	vim.bo[term_buf].bufhidden = "hide"

	-- Send Python command
	local job = vim.b[term_buf].terminal_job_id
	if job then
		vim.fn.chansend(job, python_cmd)
	end

	if focus_terminal then
		vim.api.nvim_set_current_win(term_win)
	else
		-- Return to previous window
		vim.cmd("wincmd h")
	end
end

-- Force hidden terminal buffers to close when writing and quitting ALL
vim.api.nvim_create_autocmd("ExitPre", {
	pattern = "*",
	callback = function(event)
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
	end,
})

-- Keymaps
vim.keymap.set("n", "<leader>r", function()
	run_python(false)
end, { desc = "Run Python file" })
vim.keymap.set("n", "<leader>R", function()
	run_python(true)
end, { desc = "Run Python file and focus terminal" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- LSP Configuration (after lazy.setup)
-- Lua
vim.lsp.config.lua_ls = {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
}

--    This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("sparky-lsp-attach", { clear = true }),
	callback = function(event)
		-- NOTE: Remember that Lua is a real programming language, and as such it is possible
		-- to define small helper and utility functions so you don't have to repeat yourself.
		--
		-- In this case, we create a function that lets us more easily define mappings specific
		-- for LSP related items. It sets the mode, buffer and description for us each time.
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- Rename the variable under your cursor.
		--  Most Language Servers support renaming across files, etc.
		map("grn", vim.lsp.buf.rename, "[R]e[n]ame")

		-- Execute a code action, usually your cursor needs to be on top of an error
		-- or a suggestion from your LSP for this to activate.
		map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

		-- WARN: This is not Goto Definition, this is Goto Declaration.
		--  For example, in C this would take you to the header.
		map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- Resolves difference between Neovim 0.10 and 0.11 LSP API
		---@param client vim.lsp.Client
		---@param method vim.lsp.protocol.Method
		---@param bufnr? integer Buffer number, for file-specific LSP support
		---@return boolean
		local function client_supports_method(client, method, bufnr)
			if vim.fn.has("nvim-0.11") == 1 then
				return client:supports_method(tostring(method), bufnr)
			else
				-- Old API: wrap method and bufnr in table
				return client.supports_method(client, { method = method, bufnr = bufnr })
			end
		end

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if
			client
			and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
		then
			local highlight_augroup = vim.api.nvim_create_augroup("sparky-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("sparky-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "sparky-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		-- The following code creates a keymap to toggle inlay hints in your
		-- code, if the language server you are using supports them
		--
		-- This may be unwanted, since they displace some of your code
		if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "[T]oggle Inlay [H]ints")
		end
	end,
})

-- Configure diagnostic display
vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = vim.g.have_nerd_font and {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.INFO] = "⚑",
			[vim.diagnostic.severity.HINT] = "»",
		},
	} or {},
	virtual_text = {
		source = "if_many",
		spacing = 2,
		format = function(diagnostic)
			local diagnostic_message = {
				[vim.diagnostic.severity.ERROR] = diagnostic.message,
				[vim.diagnostic.severity.WARN] = diagnostic.message,
				[vim.diagnostic.severity.INFO] = diagnostic.message,
				[vim.diagnostic.severity.HINT] = diagnostic.message,
			}
			return diagnostic_message[diagnostic.severity]
		end,
	},
})

--
--
--
--
--
--
--
--
--
