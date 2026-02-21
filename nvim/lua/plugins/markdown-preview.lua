return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "cd app && npm install", -- Use "npm install" or "yarn install"
		keys = {
			{ "gm", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
		},
		config = function()
			vim.g.mkdp_auto_close = true -- Automatically close the preview when leaving markdown buffer
			vim.g.mkdp_echo_preview_url = true -- Echo the URL to the preview server
			-- Add any other custom configuration options here (e.g., specific port, browser)
		end,
	},
}
