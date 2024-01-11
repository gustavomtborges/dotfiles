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

			vim.cmd("colorscheme github_dark")
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
			require("vscode").load()
		end,
	},
}
