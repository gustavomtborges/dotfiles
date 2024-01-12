return {
	{
		"projekt0n/github-nvim-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				options = {
					transparent = true,
					styles = {
						keywords = "bold",
					},
				},
			})
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		config = function()
			local c = require("vscode.colors").get_colors()
			require("vscode").setup({
				transparent = true,
				disable_nvimtree_bg = true,
				group_overrides = {
					["@keyword"] = { fg = c.vscBlue, bg = "none", bold = true },
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			styles = {
				keywords = { bold = true },
				floats = "transparent",
				sidebars = "transparent",
			},
		},
	},
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nightfox").setup({
				options = {
					transparent = true,
				},
				styles = {
					keywords = "bold",
				},
				groups = {
					all = {
						["@tag.attribute"] = { style = "" },
					},
				},
				palettes = {
					dayfox = {
						bg2 = "#DCE4E2", -- Lighter bg (colorcolm folds)
						bg3 = "#DCE4E2", -- Lighter bg (cursor line)
						sel0 = "#CACFC8", -- Popup bg, visual selection bg
						sel1 = "#CACFC8", -- Popup sel bg, search bg
					},
				},
			})
		end,
	},
}
