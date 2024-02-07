return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
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

			require("lualine").setup({
				component_separators = "|",
				sections = {
					lualine_a = {
						{ "mode", separator = { left = "" }, right_padding = 2 },
					},
					lualine_c = {
						{
							"filename",
							path = 1,
						},
						{ lsp_client, icon = " ", color = { fg = "#999", gui = "bold" } },
					},
					lualine_z = {
						{ "location", separator = { right = "" }, left_padding = 2 },
					},
				},
			})
		end,
	},
	-- {
	-- 	"akinsho/bufferline.nvim",
	-- 	version = "*",
	-- 	dependencies = "nvim-tree/nvim-web-devicons",
	-- 	config = true,
	-- },
	-- {
	-- 	"simrat39/symbols-outline.nvim",
	-- 	config = function()
	-- 		require("symbols-outline").setup({
	-- 			position = "left",
	-- 			width = 15,
	-- 		})
	--
	-- 		vim.keymap.set("n", "<leader>to", ":SymbolsOutline<CR>")
	-- 	end,
	-- },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = function()
			local github_dark_dimmed = {
				"github_dark_dimmed",
			}
			local tokyonight_day = {
				"tokyonight_day",
			}
			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "github_dark_dimmed", { fg = "#31363B" })
				vim.api.nvim_set_hl(0, "tokyonight_day", { fg = "#D1D3E6" })
			end)
			require("ibl").setup({
				scope = {
					enabled = false,
				},
				indent = {
					highlight = tokyonight_day,
				},
				exclude = {
					filetypes = { "dashboard", "sql", "dbout" },
				},
			})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},
	{
		"glepnir/dashboard-nvim",
		config = function()
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
					key = "SPC p",
					action = function()
						require("telescope.builtin").find_files({ previewer = false })
					end,
				},
				{
					icon = "  ",
					desc = "Open explorer                  ",
					key = "SPC e",
					action = ":NvimTreeToggle<CR>",
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
		end,
	},
}
