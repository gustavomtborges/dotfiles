return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")
		-- disable netrw at the very start of your init.lua
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = {
				side = "right",
				adaptive_size = true,
			},
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
			},
		})
	end,

	vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>"),
}
