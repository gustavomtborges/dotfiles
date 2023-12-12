return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- vim.keymap.set("n", "[d", function()
		-- 	require("trouble").previous({ skip_groups = true, jump = true })
		-- end)
		-- vim.keymap.set("n", "]d", function()
		-- 	require("trouble").next({ skip_groups = true, jump = true })
		-- end)

		vim.keymap.set("n", "<leader>td", ":TroubleToggle<CR>")
	end,
}
