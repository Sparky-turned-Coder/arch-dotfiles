return {
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "javascript", "typescript", "jsx", "tsx" }, -- File types to enable in
		after = "nvim-treesitter", -- Make sure to load after treesitter
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
				-- You can also override individual filetype configs here
				per_filetype = {
					["html"] = { enable_close = true },
				},
			})
		end,
	},
}
