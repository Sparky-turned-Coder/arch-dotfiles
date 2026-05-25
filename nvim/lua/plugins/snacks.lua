return {
	"folke/snacks.nvim",
	priority = 1000, -- Ensures it loads before other plugins
	lazy = false, -- Required for features like the dashboard or quickfile
	---@type snacks.Config
	opts = {
		-- Enable or configure specific snacks here
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		indent = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		-- Add any other snacks you want to use
	},
}
