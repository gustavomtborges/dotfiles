return {
	{
		"github/copilot.vim",
		config = function()
			vim.keymap.set("n", "<leader>tc", ":Copilot enable<CR>")
			vim.keymap.set(
				"i",
				"<C-TAB>",
				"copilot#Accept('<CR>')",
				{ noremap = true, silent = true, expr = true, replace_keycodes = false }
			)
			vim.keymap.set("i", "<C-S-TAB>", "copilot#Next()", { noremap = true, silent = true, expr = true })
			vim.g.copilot_no_tab_map = true
		end,
	},
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}, -- this is equalent to setup({}) function
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {
			filetypes = {
				"html",
				"xml",
				"markdown",
				"mdx",
				"astro",
				"elixir",
				"heex",
				"svelte",
			},
		},
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},
}
