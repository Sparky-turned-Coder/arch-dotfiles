return {
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
				stages = "fade_in_slide_out",
				timeout = 3000,
				minimum_width = 50,
				icons = {
					ERROR = "",
					WARN = "",
					INFO = "",
					DEBUG = "",
					TRACE = "✎",
				},
			})
			vim.notify = require("notify")
		end,
	},
}
