return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()
			require("neo-tree").setup({
				enable_git_status = true,
				enable_diagnostics = false,
				default_component_configs = {
					git_status = {
						symbols = {
							-- Change type
							added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
							modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
							deleted = "✖", -- this can only be used in the git_status source
							renamed = "", -- this can only be used in the git_status source
							-- Status type
							untracked = "",
							ignored = "",
							unstaged = "",
							staged = "",
							conflict = "",
						},
					},
					file_size = {
						enabled = false,
						required_width = 64, -- min width of window required to show this column
					},
					type = {
						enabled = false,
						required_width = 110, -- min width of window required to show this column
					},
					last_modified = {
						enabled = false,
						required_width = 88, -- min width of window required to show this column
					},
					created = {
						enabled = false,
						required_width = 120, -- min width of window required to show this column
					},
					symlink_target = {
						enabled = false,
					},
				},
				window = {
					position = "right",
					auto_expand_width = true,
				},
				filesystem = {
					follow_current_file = {
						enabled = true,
					},
				},
			})
		end,

		-- vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>"),
	},
	{
		"echasnovski/mini.nvim",
		version = "*",
		config = function()
			local files = require("mini.files")
			files.setup({
				mappings = {
					synchronize = "<C-s>",
				},
			})

			vim.keymap.set("n", "<leader>e", function()
				if not files.close() then
					files.open(vim.api.nvim_buf_get_name(0))
					files.reveal_cwd()
				end
			end)
		end,
	},
}
