return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.6",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				file_ignore_patterns = { ".git/", "node_modules" },
			},
			extensions = {
				fzf = true,
			},
			pickers = {
				find_files = {
					theme = "dropdown",
				},
				buffers = {
					theme = "dropdown",
				},
				oldfiles = {
					theme = "dropdown",
					cwd_only = true,
				},
			},
		})
		vim.keymap.set("n", "<C-p>", function()
			builtin.find_files({ previewer = false, hidden = true, no_ignore = true })
		end)
		vim.keymap.set("n", "<leader>p", function()
			builtin.find_files({ previewer = false, hidden = true, no_ignore = true })
		end)

		vim.keymap.set("n", "<leader>o", function()
			builtin.buffers({
				sort_mru = true,
				ignore_current_buffer = true,
				previewer = false,
			})
		end)

		vim.keymap.set("n", "<leader>fw", function()
			builtin.live_grep()
		end)

		vim.keymap.set("n", "<leader>fr", function()
			builtin.oldfiles({ previewer = false })
		end)

		vim.keymap.set("n", "<leader>ff", function()
			builtin.find_files({ previewer = false, hidden = true, no_ignore = true })
		end)

		vim.keymap.set("n", "<leader>fg", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)

		-- LSP
		vim.keymap.set("n", "<leader>cj", function()
			builtin.lsp_document_symbols()
		end)

		-- GIT
		vim.keymap.set("n", "<leader>gs", function()
			require("telescope.builtin").git_status()
		end)
		vim.keymap.set("n", "<leader>gc", function()
			require("telescope.builtin").git_commits()
		end)
		vim.keymap.set("n", "<leader>gh", function()
			require("telescope.builtin").git_bcommits()
		end)
	end,
}
