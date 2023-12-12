require("bufferline").setup({
	options = {
		buffer_close_icon = "",
	},
})
require("neoscroll").setup()
require("colorizer").setup()
local telescope = require("telescope")
telescope.load_extension("fzf")
telescope.setup({
  pickers = {
    oldfiles = {
      cwd_only = true
    }
  }
})

vim.opt.list = false
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

local solarized_highlight = {
	"Solarized",
}

local onedark_highlight = {
	"OneDark",
}

local hooks = require("ibl.hooks")
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "Solarized", { fg = "#EDE6C7" })
	vim.api.nvim_set_hl(0, "OneDark", { fg = "#ececec" })
end)

require("ibl").setup({
	exclude = { filetypes = { "dashboard" } },
	scope = { enabled = false },
})

local function list_registered_providers_names(filetype)
	local s = require("null-ls.sources")
	local available_sources = s.get_available(filetype)
	local registered = {}
	for _, source in ipairs(available_sources) do
		for method in pairs(source.methods) do
			registered[method] = registered[method] or {}
			table.insert(registered[method], source.name)
		end
	end
	return registered
end

local function list_registered_formatters(filetype)
	local method = require("null-ls").methods.FORMATTING
	local registered_providers = list_registered_providers_names(filetype)
	return registered_providers[method] or {}
end

local function list_registered_linters(filetype)
	local method = require("null-ls").methods.DIAGNOSTICS
	local registered_providers = list_registered_providers_names(filetype)
	return registered_providers[method] or {}
end

local function list_registered_hovers(filetype)
	local method = require("null-ls").methods.HOVER
	local registered_providers = list_registered_providers_names(filetype)
	return registered_providers[method] or {}
end

local function lsp_client(msg)
	msg = msg or ""
	local buf_clients = vim.lsp.buf_get_clients()
	if next(buf_clients) == nil then
		if type(msg) == "boolean" or #msg == 0 then
			return ""
		end
		return msg
	end

	local buf_ft = vim.bo.filetype
	local buf_client_names = {}

	-- add client
	for _, client in pairs(buf_clients) do
		if client.name ~= "null-ls" then
			table.insert(buf_client_names, client.name)
		end
	end

	-- add formatter
	local supported_formatters = list_registered_formatters(buf_ft)
	vim.list_extend(buf_client_names, supported_formatters)

	-- add linter
	local supported_linters = list_registered_linters(buf_ft)
	vim.list_extend(buf_client_names, supported_linters)

	-- add hover
	-- local supported_hovers = list_registered_hovers(buf_ft)
	-- vim.list_extend(buf_client_names, supported_hovers)

	return "[" .. table.concat(buf_client_names, ", ") .. "]"
end

require("lspsaga").setup({
	ui = {
		code_action = " ",
	},
	symbol_in_winbar = {
		enable = false,
		color_mode = false,
	},
})

require("lualine").setup({
	sections = {
		lualine_c = {
			{
				"filename",
				path = 1,
			},
			"lsp_progress",
			{ lsp_client, icon = " ", color = { fg = "#999", gui = "bold" } },
		},
	},
})

require("symbols-outline").setup({
	position = "left",
	width = 15,
})

local signs = {
	Error = " ",
	Warn = " ",
	Hint = " ",
	Info = " ",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

--DASHBOARD
local custom_header = {
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[  ██████   █████                   █████   █████  ███                  ]],
	[[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
	[[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
	[[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
	[[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
	[[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
	[[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
	[[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
}
local custom_center = {
	{
		icon = "  ",
		desc = "Find files                     ",
		key = "SPC p ",
		action = function()
			require("telescope.builtin").find_files({ previewer = false })
		end,
	},
	{
		icon = "  ",
		desc = "Find word                     ",
		key = "SPC f w",
		action = function()
			require("telescope.builtin").live_grep()
		end,
	},
	{
		icon = "  ",
		desc = "Find recent files             ",
		key = "SPC f r",
		action = function()
			require("telescope.builtin").oldfiles()
		end,
	},
}
local custom_footer = {
	[[ ]],
	[[ ]],
	"One day at a time  ",
}
require("dashboard").setup({
	theme = "doom",
	config = {
		header = custom_header,
		center = custom_center,
		footer = custom_footer,
	},
})
