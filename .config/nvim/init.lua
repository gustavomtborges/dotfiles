require("user.options")
require("user.keymaps")
require("user.lazy")

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.cmd("colorscheme vscode")
