return {
	-- add nordic colorscheme
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
	},

	-- Configure LazyVim to load nordic
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "nordic",
		},
	},
}
