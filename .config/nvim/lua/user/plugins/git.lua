return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>tg", ":G ")
		end,
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = function()
			require("git-conflict").setup({
				default_mappings = {
					next = "]x",
					prev = "[x",
				},
			})

			vim.keymap.set("n", "<leader>gx", ":GitConflictListQf<CR>")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					vim.keymap.set("n", "[g", gs.prev_hunk, { buffer = bufnr })
					vim.keymap.set("n", "]g", gs.next_hunk, { buffer = bufnr })

					vim.keymap.set({ "n", "v" }, "<leader>ga", function()
						gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { buffer = bufnr })
					vim.keymap.set({ "n", "v" }, "<leader>gr", function()
						gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end, { buffer = bufnr })

					vim.keymap.set("n", "<leader>gb", gs.toggle_current_line_blame)

					vim.keymap.set("n", "<leader>gA", gs.stage_buffer, { buffer = bufnr })
					vim.keymap.set("n", "<leader>gR", gs.reset_buffer, { buffer = bufnr })

					vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = bufnr })
					vim.keymap.set("n", "<leader>gd", gs.diffthis, { buffer = bufnr })
					vim.keymap.set("n", "<leader>gD", function()
						gs.diffthis("~")
					end, { buffer = bufnr })
				end,
			})
		end,
	},
}
