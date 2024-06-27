vim.g.mapleader = " "

vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", "Q", "<nop>")

-- Save with <C-s>
vim.keymap.set({ "n" }, "<C-s>", ":update<CR>")

-- Copy to clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

vim.keymap.set({ "n", "v" }, "<M-d>", '"_d')

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
vim.keymap.set("x", "<M-p>", '"_dP')

-- Buffers
vim.keymap.set("n", "<C-n>", ":bprev<CR>")
vim.keymap.set("n", "<C-t>", ":bnext<CR>")
vim.keymap.set("n", "<leader>w", ":bd<CR>")
vim.keymap.set("n", "<leader>bk", ":bd!<CR>")

-- Tabs
vim.keymap.set("n", "<leader>nc", ":tabnew<CR>")
vim.keymap.set("n", "<leader>nn", ":tabnext<CR>")
vim.keymap.set("n", "<leader>nd", ":tabclose<CR>")

-- Spilts
vim.keymap.set("n", "<M-h>", "<C-w><C-h>")
vim.keymap.set("n", "<M-l>", "<C-w><C-l>")
vim.keymap.set("n", "<M-j>", "<C-w><C-j>")
vim.keymap.set("n", "<M-k>", "<C-w><C-k>")

-- Spilts resize
vim.keymap.set("n", "<M-S-h>", "<C-w>>")
vim.keymap.set("n", "<M-S-l>", "<C-w><")
vim.keymap.set("n", "<M-S-j>", "<C-w>-")
vim.keymap.set("n", "<M-S-k>", "<C-w>+")

vim.keymap.set("n", "<leader>q", ":q<CR>")

-- Toggles
vim.keymap.set("n", "<leader>th", ":nohl<CR>")
vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>")
vim.keymap.set("n", "<leader>ts", ":set spell!<CR>")
vim.keymap.set("n", "<leader>tc", ":set list!<CR>")
