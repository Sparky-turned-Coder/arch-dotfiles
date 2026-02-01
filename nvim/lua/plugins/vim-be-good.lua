return {
	"thePrimeagen/vim-be-good",
	cmd = "VimBeGood", -- Command to trigger the plugin
	config = function()
		require("VimBeGood").setup({}) -- Setup function (can add options here)
	end,
}
