vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
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

require("config.lazy")
require("config.keymaps")
require("custom.filetypes")
require("config.run-python")

-- Highlight when yanking text
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

-- Force hidden terminal buffers to close when writing and quitting ALL
vim.api.nvim_create_autocmd("ExitPre", {
	pattern = "*",
	callback = function(event)
		for _, buf in ipairs(vim.api.nvim_list_bufs()) do
			if vim.bo[buf].buftype == "terminal" then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
	end,
})

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

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

print("Hello, from Init.lua!")
