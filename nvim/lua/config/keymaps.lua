vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal insert mode" })

vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>")
vim.keymap.set("n", "<leader>mpS", ":MarkdownPreviewStop<CR>")
vim.keymap.set("n", "<leader>pv", ":Explore<CR>")
vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")

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

-- Navigate between splits with Ctrl + hjkl
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })

vim.keymap.set("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close all other buffers" })
vim.keymap.set("n", "<leader>a", ":wqa<CR>", { desc = "save and quit all" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader>th", [[<cmd>split | term<cr>]], { desc = "Open terminal in horizontal split" })
vim.keymap.set("n", "<leader>tv", [[<cmd>vsplit | term<cr>]], { desc = "Open terminal in vertical split" })

-- Example mapping <Leader>f to format
vim.keymap.set("n", "<Leader>f", "<Cmd>Format<CR>", { desc = "Format file" })
