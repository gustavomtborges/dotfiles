vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "K", "<nop>")
vim.keymap.set("n", "Q", "<nop>")

-- Save with <C-s>
vim.keymap.set("n", "<C-s>", ":update<CR>")

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

-- Buffers
vim.keymap.set("n", "<C-h>", ":bprev<CR>")
vim.keymap.set("n", "<C-l>", ":bnext<CR>")
vim.keymap.set("n", "<leader>w", ":bd<CR>")

-- Spilts
vim.keymap.set("n", "<leader>h", "<C-w><C-h>")
vim.keymap.set("n", "<leader>l", "<C-w><C-l>")
vim.keymap.set("n", "<leader>sv", "<C-w>v")
vim.keymap.set("n", "<leader>sh", "<C-w>s")
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- Toggles
vim.keymap.set("n", "<leader>th", ":nohl<CR>")
vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>")
vim.keymap.set("n", "<leader>ts", ":set spell!<CR>")
