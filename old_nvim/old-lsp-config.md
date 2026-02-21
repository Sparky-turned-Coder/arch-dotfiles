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
root_dir = vim.fs.root(0, {
".luarc.json",
".luarc.jsonc",
".luacheckrc",
".stylua.toml",
"stylua.toml",
"selene.toml",
"selene.yml",
".git",
}),
settings = {
Lua = {
diagnostics = { globals = { "vim" } },
},
},
})
end,
})

vim.api.nvim_create_autocmd("Filetype", {
pattern = { "sh", "bash" },
callback = function()
vim.lsp.start({
name = "bashls",
cmd = { "bash-language-server", "start" },
root_dir = vim.fs.root(0, { ".git", "setup.cfg", ".bashlsrc" }),
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

---

-- LSP Keybindings (set when LSP attaches)
vim.api.nvim_create_autocmd("LspAttach", {
callback = function(args)
local opts = { buffer = args.buf }

    	-- Hover documentation
    	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

    	-- Go to definition
    	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

    	-- Go to declaration
    	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    	-- Find references
    	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    	-- Go to implementation
    	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

    	-- Show signature help (function parameters)
    	vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, opts)

    	-- Rename symbol
    	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    	-- Code actions
    	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    	-- Format buffer
    	vim.keymap.set("n", "<leader>f", function()
    		require("conform").format({ async = true, lsp_fallback = true })
    	end, opts)
    end,

})
