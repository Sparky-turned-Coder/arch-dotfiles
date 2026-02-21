return {
	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			-- Set up nvim-cmp
			cmp.setup({
				-- Define key mappings
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(), -- Select previous item
					["<C-n>"] = cmp.mapping.select_next_item(), -- Select next item
					["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Scroll documentation up
					["<C-f>"] = cmp.mapping.scroll_docs(4), -- Scroll documentation down
					["<C-Space>"] = cmp.mapping.complete(), -- Manually trigger completion
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item
					["<C-e>"] = cmp.mapping.abort(), -- Abort completion
				}),

				-- Define completion sources and their priority
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},

				-- Further customization (optional)
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*", -- follow the latest release major version
		build = "make install_jsregexp", -- installs jsregexp
	},
}
