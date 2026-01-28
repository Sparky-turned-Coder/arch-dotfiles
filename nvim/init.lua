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

vim.g.have_nerd_font = true


-- Vim Keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
--vim.keymap.set("n", "<C-k>", "<C-w>k")
--vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal insert mode"})
vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>")
vim.keymap.set("n", "<leader>pv", ":Explore<CR>")
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader>pf", ":Pick files<CR>", { desc = "Pick files" })
vim.keymap.set("n", "<leader>pb", ":Pick buffers<CR>", { desc = "Pick buffers" })
vim.keymap.set("n", "<leader>pg", ":Pick grep_live<CR>", { desc = "Pick grep (search in files)" })
vim.keymap.set("n", "<leader>ph", ":Pick help<CR>", { desc = "Pick help tags" })
-- vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Floating window with error details"})

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

-- Treesitter
{
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.config").setup({
      ensure_installed = { "lua", "python", "markdown", "markdown_inline", "javascript", "typescript", "html", "css", "c", "c++" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
},

-- Which-key
{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
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
								"pyright",		-- Python
								"lua_ls",		-- Lua
								"ts_ls",		-- Typescript/Javascript
								"marksman",		-- Markdown
								"html",			-- HTML
								"cssls",		-- CSS
								"clangd",		-- C/C++
						},
				})
		end,
},


-- Mini.pick (fuzzy finder)
{
"echasnovski/mini.pick",
config = function()
		require("mini.pick").setup({
		mappings = {
		move_down = '<C-j>',
		move_up = '<C-k>',
},
})
end,
},

})

-- Configure diagnostic display
vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

 -- LSP Configuration
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.lsp.start({
      name = "pyright",
      cmd = { "pyright-langserver", "--stdio" },
      root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py", ".git" }),
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.lsp.start({
      name = "lua_ls",
      cmd = { "lua-language-server" },
      root_dir = vim.fs.root(0, { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" }),
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
        },
      },
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.lsp.start({
      name = "ts_ls",
      cmd = { "typescript-language-server", "--stdio" },
      root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }),
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.lsp.start({
      name = "marksman",
      cmd = { "marksman", "server" },
      root_dir = vim.fs.root(0, { ".git", ".marksman.toml" }),
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    vim.lsp.start({
      name = "html",
      cmd = { "vscode-html-language-server", "--stdio" },
      root_dir = vim.fs.root(0, { "package.json", ".git" }),
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "css",
  callback = function()
    vim.lsp.start({
      name = "cssls",
      cmd = { "vscode-css-language-server", "--stdio" },
      root_dir = vim.fs.root(0, { "package.json", ".git" }),
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.lsp.start({
      name = "clangd",
      cmd = { "clangd" },
      root_dir = vim.fs.root(0, { "compile_commands.json", "compile_flags.txt", ".git" }),
    })
  end,
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
--
--
