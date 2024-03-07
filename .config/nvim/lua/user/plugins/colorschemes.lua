return {
	{
		"projekt0n/github-nvim-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				options = {
					transparent = true,
				},
			})
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		config = function()
			require("vscode").setup({
				transparent = true,
				disable_nvimtree_bg = false,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = true,
				styles = {
					comments = "none",
					keywords = "none",
					sidebars = "transparent",
					floats = "transparent",
				},
			})
		end,
	},
	{
		"navarasu/onedark.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("onedark").setup({
				transparent = true,
				code_style = {
					comments = "italic",
					keywords = "italic",
					functions = "none",
				},
				-- colors = {
				-- 	bg3 = "#4D5563",
				-- },
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
			})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		config = true,
		opts = {
			bold = false,
			italic = {
				strings = false,
				emphasis = false,
				comments = false,
				operators = false,
				folds = true,
			},
			transparent_mode = true,
		},
	},
}
