vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "K", "<nop>")
vim.keymap.set("n", "Q", "<nop>")

-- Save with Ctrl-s
vim.keymap.set("n", "<C-s>", ":<c-u>update<CR>")

-- Move esasly between splits
-- vim.keymap.set("n", "<C-j>", "<C-w><C-j>", default_opts)
-- vim.keymap.set("n", "<C-k>", "<C-w><C-k>", default_opts)
-- vim.keymap.set("n", "<C-l>", "<C-w><C-l>", default_opts)
-- vim.keymap.set("n", "<C-h>", "<C-w><C-h>", default_opts)

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- utils

-- Preserve cursor at the beginning
vim.keymap.set("n", "J", "mzJ`z")
-- Preserve cursor at the center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Preserve paste
vim.keymap.set("x", "<leader>p", '"_dP')
