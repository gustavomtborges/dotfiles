return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		"tpope/vim-dadbod",
		"kristijanhusak/vim-dadbod-completion",
	},
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_win_position = "right"
		vim.g.db_ui_execute_on_save = 0
		vim.g.db_ui_save_location = "~/Dropbox/db_ui"
	end,
	config = function()
		vim.keymap.set("n", "<leader>tb", ":DBUIToggle<CR>")
	end,
}
