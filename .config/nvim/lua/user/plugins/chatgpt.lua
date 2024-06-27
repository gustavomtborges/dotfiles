return {
	"jackMort/ChatGPT.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local home = vim.fn.expand("$HOME")
		require("chatgpt").setup({
			api_key_cmd = "gpg --decrypt " .. home .. "/chatgpt-secret.txt.gpg",
		})
		vim.keymap.set({ "n", "v" }, "<leader>ct", "<cmd>ChatGPTRun translate<CR>")
		vim.keymap.set({ "n", "v" }, "<leader>cg", "<cmd>ChatGPTRun grammar_correction<CR>")
	end,
}
