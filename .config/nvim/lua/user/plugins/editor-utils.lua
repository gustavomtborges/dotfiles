return {
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
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
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			require("git-conflict").setup()

			vim.keymap.set("n", "<leader>gx", ":GitConflictListQf<CR>")
		end,
	},
}
