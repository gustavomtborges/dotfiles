vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.termencoding = "utf-8"
vim.opt.hidden = true -- Enable background buffers
vim.opt.inccommand = "split" -- Show command preview
vim.opt.shiftwidth = 2 -- Number of spaces inserted for each identation
vim.opt.tabstop = 2 -- Insert 4 spaces for a tab
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.incsearch = true -- Search strings as you type
vim.opt.hlsearch = true -- Highlight search strings
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true -- Do not ignore case with Capitals
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.updatetime = 300 -- Quicker update
vim.opt.termguicolors = true -- True color support
vim.opt.splitbelow = true -- Put new windows below current
vim.opt.splitright = true -- Put new windows right of current
vim.opt.mouse = "a" -- allow the mouse to be used
vim.opt.number = true -- Show number lines
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.showmode = false -- No need to show -- INSERT -- anymore
vim.opt.scrolloff = 8 -- Lines of context after EOL
vim.opt.listchars = { tab = "→ ", trail = "∙", eol = "¬" }
vim.opt.list = false
vim.opt.signcolumn = "yes"

-- witch-key settings
vim.opt.timeout = true
vim.opt.timeoutlen = 500

--vim.opt.clipboard = "unnamed" -- Copy and paste with OS clipboard
vim.opt.cursorline = true -- Highlight the current line
vim.opt.colorcolumn = "80" -- Show column ruler
vim.opt.wrap = false -- Don't wrap lines
vim.opt.fillchars = { fold = " " }
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.opt.spelllang = { "pt_br", "en_us" }
vim.opt.spell = false

--Fix folding with treesitter
vim.api.nvim_create_autocmd("BufRead", {
	callback = function()
		vim.api.nvim_create_autocmd("BufWinEnter", {
			once = true,
			command = "normal! zx zR",
		})
	end,
})

require("tokyonight").setup({
	transparent = true,
	styles = {
		keywords = "bold",
	},
})

require("github-theme").setup({
	options = {
		transparent = true,
	},
})

require("nightfox").setup({
	options = {
		transparent = true,
		styles = {
			keywords = "bold",
		},
	},
	palettes = {
		nightfox = {
			bg2 = "#39404f", -- Lighter bg (colorcolm folds)
			bg3 = "#444c5e", -- Lighter bg (cursor line)
			sel0 = "#3e4a5b", -- Popup bg, visual selection bg
			sel1 = "#4f6074", -- Popup sel bg, search bg
		},
		dayfox = {
			bg2 = "#DCE4E2", -- Lighter bg (colorcolm folds)
			bg3 = "#DCE4E2", -- Lighter bg (cursor line)
			sel0 = "#CACFC8", -- Popup bg, visual selection bg
			sel1 = "#CACFC8", -- Popup sel bg, search bg
		},
	},
})

require("onedark").setup({
	transparent = true,
	code_style = {
		keywords = "bold",
	},
})

require("solarized").setup({
	transparent = true,
	styles = {
		keywords = { bold = true },
	},
})

require("catppuccin").setup({
	transparent_background = true,
	styles = {
		keywords = { "bold" },
	},
})

vim.g.sonokai_transparent_background = 1
vim.g.everforest_background = "medium"
vim.g.everforest_transparent_background = 1
vim.g.edge_transparent_background = 1

local c = require("vscode.colors").get_colors()
require("vscode").setup({
	transparent = true,
	disable_nvimtree_bg = true,
	group_overrides = {
		["@keyword"] = { fg = c.vscBlue, bg = "none", bold = true },
	},
})
require("vscode").load()

-- Set colorscheme
vim.opt.background = "dark"
vim.cmd("colorscheme vscode")
