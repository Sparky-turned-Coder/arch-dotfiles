return {
	{
		"folke/lazydev.nvim",
		lazy = false,
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
