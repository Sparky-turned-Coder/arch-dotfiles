return {
	"fatih/vim-go",
	ft = "go",
	build = ":GoInstallBinaries", -- This runs the command after installation
	config = function()
		-- Your specific custom configuration options can go here
		vim.g.go_def_mode = "gopls" -- Example setting
		vim.g.go_info_mode = "gopls"
	end,
}
