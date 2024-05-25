return {
	{
		"projekt0n/github-nvim-theme",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("github-theme").setup({
				groups = {
					all = {
						["@type"] = { fg = "palette.fg.default" },
						["@type.definition"] = { fg = "palette.fg.default" },
						["@type.builtin"] = { fg = "palette.fg.default" },
						["@module"] = { fg = "palette.fg.on_emphasis" },
						["@module.go"] = { fg = "palette.fg.on_emphasis" },
						["@tag.delimiter"] = { fg = "palette.fg.on_emphasis" },
						["@string.special"] = { fg = "palette.fg.on_emphasis" },
						["@string.special.url"] = { style = "NONE" },
						["@operator"] = { fg = "palette.fg.on_emphasis" },
						["@keyword.templ"] = { fg = "syntax.tag" },
						["@variable.member.lua"] = { fg = "palette.fg.default" },
					},
				},
				options = {
					transparent = true,
					darken = {
						floats = false,
					},
					styles = {
						comments = "NONE",
						keywords = "NONE",
						constants = "NONE",
					},
				},
			})
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		config = function()
			local c = require("vscode.colors").get_colors()
			require("vscode").setup({
				transparent = true,
				group_overrides = {
					["@keyword"] = { fg = c.vscBlue, bold = false },
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		config = function()
			require("tokyonight").setup({
				transparent = true,
				styles = {
					comments = "NONE",
					keywords = "NONE",
					functions = "NONE",
					sidebars = "transparent",
					-- floats = "transparent",
				},
				on_highlights = function(hl, c)
					hl["@module"] = {
						fg = c.orange,
					}
					hl["@keyword.import"] = {
						fg = c.purple,
					}
					hl["@keyword.directive"] = {
						fg = c.purple,
					}
				end,
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
					comments = "NONE",
					keywords = "NONE",
					functions = "NONE",
				},
			})
		end,
	},
}
