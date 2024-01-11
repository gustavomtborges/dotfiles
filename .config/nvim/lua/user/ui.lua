-- require("bufferline").setup({
-- 	options = {
-- 		buffer_close_icon = "",
-- 	},
-- })

require("gitsigns").setup()
require("colorizer").setup()

local solarized_highlight = {
	"Solarized",
}

local onedark_highlight = {
	"OneDark",
}

-- local hooks = require("ibl.hooks")
-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
-- 	vim.api.nvim_set_hl(0, "Solarized", { fg = "#EDE6C7" })
-- 	vim.api.nvim_set_hl(0, "OneDark", { fg = "#ececec" })
-- end)
--
-- require("ibl").setup({
-- 	exclude = { filetypes = { "dashboard" } },
-- 	scope = { enabled = false },
-- 	-- indent = { highlight = solarized_highlight },
-- })
