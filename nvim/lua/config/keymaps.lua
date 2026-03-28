-- ============================================================================
--  KEYMAPS
-- ============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- better movement in wrapped text
vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal insert mode" })

vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>")
vim.keymap.set("n", "<leader>lp", ":LivePreview start<CR>")
vim.keymap.set("n", "<leader>pv", ":Explore<CR>")
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")

vim.keymap.set("n", "<leader>pp", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

-- Splitting and Re-sizing windows
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Moving entire lines and selections up and down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move current line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move current line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv==gv", { desc = "Move selection line down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv==gv", { desc = "Move selection line up" })

-- Indenting a selection left and right
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Mini Pick keymaps
vim.keymap.set("n", "<leader>pf", ":Pick files<CR>", { desc = "Pick files" })
vim.keymap.set("n", "<leader>pb", ":Pick buffers<CR>", { desc = "Pick buffers" })
vim.keymap.set("n", "<leader>pg", ":Pick grep_live<CR>", { desc = "Pick grep (search in files)" })
vim.keymap.set("n", "<leader>ph", ":Pick help<CR>", { desc = "Pick help tags" })

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

--NOTE: Lua keymaps in Neovim are already "noremap" by default.
--      Thus, the line below is unnecessary.
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })

-- Close all other buffers & Navigate between existing buffers
vim.keymap.set("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close all other buffers" })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<leader>a", ":wqa<CR>", { desc = "save and quit all" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>th", [[<cmd>split | term<cr>]], { desc = "Open terminal in horizontal split" })
vim.keymap.set("n", "<leader>tv", [[<cmd>vsplit | term<cr>]], { desc = "Open terminal in vertical split" })

-- show file path
vim.keymap.set("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file: ", path)
end, { desc = "Copy full file path" })

-- Example mapping <Leader>f to format
vim.keymap.set("n", "<Leader>f", "<Cmd>Format<CR>", { desc = "Format file" })
