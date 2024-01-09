local default_opts = { noremap = true, silent = true }
local function keymap(mode, lhs, rhs, opts)
	local options = {}
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

keymap("i", "jk", "<esc>", default_opts)
keymap("", "K", "<nop>")

-- Save with Ctrl-s
keymap("n", "<C-s>", ":<c-u>update<CR>", default_opts)
keymap("v", "<C-s>", ":<c-c>update<CR>gv", default_opts)
keymap("i", "<C-s>", ":<c-o>update<CR>", default_opts)

-- Move esasly between splits
-- keymap("n", "<C-j>", "<C-w><C-j>", default_opts)
-- keymap("n", "<C-k>", "<C-w><C-k>", default_opts)
-- keymap("n", "<C-l>", "<C-w><C-l>", default_opts)
-- keymap("n", "<C-h>", "<C-w><C-h>", default_opts)

-- Copy to clipboard
keymap("v", "Y", '"+y', default_opts)

local wk = require("which-key")
wk.setup({
	layout = {
		align = "center",
	},
})

wk.register({
	["<leader>p"] = {
		function()
			require("telescope.builtin").find_files({ previewer = false })
		end,
		"Find File",
	},
	["<leader>e"] = {
		":NvimTreeToggle<CR>",
		"File explorer",
	},
	["<leader>j"] = {
		":BufferLineCyclePrev<CR>",
		"Previous buffer",
	},
	["<leader>J"] = {
		":BufferLineMovePrev<CR>",
		"Move buffer left",
	},
	["<leader>k"] = {
		":BufferLineCycleNext<CR>",
		"Next buffer",
	},
	["<leader>K"] = {
		":BufferLineMoveNext<CR>",
		"Move buffer right",
	},
	["<leader>;"] = {
		function()
			require("telescope.builtin").buffers({
				sort_mru = true,
				ignore_current_buffer = true,
				previewer = false,
			})
		end,
		"Opened buffers",
	},
	["<leader>q"] = {
		":Bdelete<CR>",
		"Close buffer",
	},
	["<leader>Q"] = {
		":q<CR>",
		"Close window",
	},
	["[g"] = {
		function()
			require("gitsigns").prev_hunk({ buffer = true })
		end,
		"Previous change",
	},
	["[d"] = {
		function()
			vim.diagnostic.goto_prev()
		end,
		"Previous diagnostic",
	},
	["]g"] = {
		function()
			require("gitsigns").next_hunk({ buffer = true })
		end,
		"Next change",
	},
	["]d"] = {
		function()
			vim.diagnostic.goto_next()
		end,
		"Next diagnostic",
	},
	["<leader>R"] = {
		"*``cgn",
		"Replace word forward",
	},
	["<leader>f"] = {
		name = "+file",
	},
	["<leader>fw"] = {
		function()
			require("telescope.builtin").live_grep()
		end,
		"Find word",
	},
	["<leader>fm"] = {
		function()
			require("telescope.builtin").marks()
		end,
		"Find bookmarks",
	},
	["<leader>fr"] = {
		function()
			require("telescope.builtin").oldfiles()
		end,
		"Find recent files",
	},
	["<leader>ff"] = {
		function()
			require("telescope.builtin").find_files({ previewer = false, hidden = true })
		end,
		"Find files (.hidden)",
	},
	["<leader>fc"] = {
		function()
			require("telescope.builtin").grep_string()
		end,
		"Find word under cursor",
	},
	["<leader>c"] = { name = "+code [LSP]" },
	["gd"] = {
		function()
			vim.lsp.buf.definition()
		end,
		"Go to definition",
	},
	["gD"] = {
		function()
			vim.lsp.buf.declaration()
		end,
		"Go to declaration",
	},
	["gr"] = {
		function()
			vim.lsp.buf.references()
		end,
		"Go to references",
	},
	["<leader>ci"] = {
		function()
			require("telescope.builtin").lsp_implementations()
		end,
		"Go to implementation",
	},
	["<leader>r"] = {
		function()
			vim.lsp.buf.rename()
		end,
		"",
	},
	["<leader>h"] = {
		function()
			vim.lsp.buf.hover()
		end,
		"Preview docs",
	},
	["<leader>H"] = {
		function()
			vim.lsp.buf.signature_help()
		end,
		"Preview signature",
	},
	["<leader>ca"] = {
		"<cmd>Lspsaga code_action<CR>",
		"Code actions",
	},
	["<leader>cj"] = {
		function()
			require("telescope.builtin").lsp_document_symbols()
		end,
		"Jump to symbol",
	},
	["<leader>cf"] = {
		function()
			vim.lsp.buf.format({ buffer = true, async = true })
		end,
		"Format buffer",
	},
	["<leader>g"] = { name = "+git" },
	["<leader>gs"] = {
		function()
			require("telescope.builtin").git_status()
		end,
		"List git changes",
	},
	["<leader>gb"] = {
		function()
			require("telescope.builtin").git_branches()
		end,
		"List git branches",
	},
	["<leader>gc"] = {
		function()
			require("telescope.builtin").git_commits()
		end,
		"List commits",
	},
	["<leader>gh"] = {
		function()
			require("telescope.builtin").git_bcommits()
		end,
		"Show file history",
	},
	["<leader>gx"] = {
		":GitConflictListQf<CR>",
		"Comflict files",
	},
	["<leader>ga"] = {
		":Gitsigns stage_hunk<CR>",
		"Stage hunk",
	},
	["<leader>gr"] = {
		":Gitsigns reset_hunk<CR>",
		"Restore hunk",
	},
	["<leader>gA"] = {
		function()
			require("gitsigns").stage_buffer()
		end,
		"Stage buffer",
	},
	["<leader>gR"] = {
		function()
			require("gitsigns").reset_buffer()
		end,
		"Restore buffer",
	},
	["<leader>gp"] = {
		function()
			require("gitsigns").preview_hunk()
		end,
		"Preview hunk",
	},
	["<leader>gl"] = {
		function()
			require("gitsigns").toggle_current_line_blame()
		end,
		"Blame",
	},
	["<leader>gd"] = {
		function()
			require("gitsigns").diffthis()
		end,
		"Diff",
	},
	["<leader>gD"] = {
		function()
			require("gitsigns").diffthis("~")
		end,
		"Diff buffer",
	},
	["<leader>o"] = {
		name = "+open",
	},
	["<leader>oe"] = {
		":NvimTreeToggle<CR>",
		"Project explorer",
	},
	["<leader>os"] = {
		":SymbolsOutline<CR>",
		"Symbols outline",
	},
	["<leader>od"] = {
		":TroubleToggle<CR>",
		"Diagnostic",
	},
	["<leader>oD"] = {
		":TroubleToggle workspace_diagnostics<CR>",
		"Diagnostic Workspace",
	},
	["<leader>oq"] = {
		":copen<CR>",
		"Quickfix",
	},
	["<leader>om"] = {
		":MarkdownPreview<CR>",
		"Markdown Preview",
	},
	["<leader>t"] = {
		name = "+toggle",
	},
	["<leader>th"] = {
		":nohl<CR>",
		"Search highligh",
	},
	["<leader>tw"] = {
		":set wrap!<CR>",
		"Word wrap",
	},
	["<leader>tc"] = {
		":set list!<CR>",
		"Hidden chars",
	},
	["<leader>ts"] = {
		":set spell!<CR>",
		"Spell checking",
	},
	["<leader>b"] = {
		name = "+buffers",
	},
	["<leader>bk"] = {
		":Bdelete<CR>",
		"Close buffer",
	},
	["<leader>bK"] = {
		":%Bdelete<CR>",
		"Close all buffers",
	},
	["<leader>bl"] = {
		function()
			require("telescope.builtin").buffers({
				sort_mru = true,
				ignore_current_buffer = true,
			})
		end,
		"Opened buffers",
	},
	["<leader>bn"] = {
		":BufferLineMoveNext<CR>",
		"Move Next",
	},
	["<leader>bp"] = {
		":BufferLineMovePrev<CR>",
		"Move Previous",
	},
	["<leader>z"] = {
		name = "+zettelkasten",
	},
	["<leader>za"] = {
		function()
			require("telekasten").panel()
		end,
		"All options",
	},
	["<leader>zf"] = {
		function()
			require("telekasten").find_notes()
		end,
		"Find notes",
	},
	["<leader>zn"] = {
		function()
			require("telekasten").new_note()
		end,
		"New note",
	},
	["<leader>zt"] = {
		function()
			require("telekasten").show_tags()
		end,
		"Find tags",
	},
	["<leader>zi"] = {
		function()
			require("telekasten").insert_link()
		end,
		"Insert link",
	},
	["<leader>zl"] = {
		function()
			require("telekasten").follow_link()
		end,
		"Follow link",
	},
	["<leader>zr"] = {
		function()
			require("telekasten").rename_note()
		end,
		"Rename note",
	},
	["<leader>zd"] = {
		function()
			require("telekasten").goto_today()
		end,
		"Go to today",
	},
	["<leader>zw"] = {
		function()
			require("telekasten").goto_thisweek()
		end,
		"Go to this week",
	},
	["<leader>zc"] = {
		function()
			require("telekasten").show_calendar()
		end,
		"Show calendar",
	},
})

wk.register({
	g = {
		name = "+git",
	},
	["<leader>ga"] = {
		":Gitsigns stage_hunk<CR>",
		"Stage hunk",
	},
	["<leader>gr"] = {
		":Gitsigns reset_hunk<CR>",
		"Reset hunk",
	},
}, { mode = "v" })
