return {
	{
		"nvim-lualine/lualine.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "nvim-tree/nvim-web-devicons" },
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

			-- local function list_registered_formatters(filetype)
			-- 	local method = require("null-ls").methods.FORMATTING
			-- 	local registered_providers = list_registered_providers_names(filetype)
			-- 	return registered_providers[method] or {}
			-- end
			--
			-- local function list_registered_linters(filetype)
			-- 	local method = require("null-ls").methods.DIAGNOSTICS
			-- 	local registered_providers = list_registered_providers_names(filetype)
			-- 	return registered_providers[method] or {}
			-- end
			--
			-- local function list_registered_hovers(filetype)
			-- 	local method = require("null-ls").methods.HOVER
			-- 	local registered_providers = list_registered_providers_names(filetype)
			-- 	return registered_providers[method] or {}
			-- end

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
				-- local supported_formatters = list_registered_formatters(buf_ft)
				-- vim.list_extend(buf_client_names, supported_formatters)

				-- add linter
				-- local supported_linters = list_registered_linters(buf_ft)
				-- vim.list_extend(buf_client_names, supported_linters)

				-- add hover
				-- local supported_hovers = list_registered_hovers(buf_ft)
				-- vim.list_extend(buf_client_names, supported_hovers)

				return "[" .. table.concat(buf_client_names, ", ") .. "]"
			end

			require("lualine").setup({
				options = {
					component_separators = "|",
					section_separators = { left = "", right = "" },
				},
				sections = {
					lualine_a = {
						{ "mode", separator = { left = "" }, right_padding = 2 },
					},
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = {
						{
							"filename",
							path = 1,
						},
					},
					lualine_x = {
						{ lsp_client, icon = " ", color = { fg = "#999", gui = "bold" } },
						"encoding",
						"filetype",
					},
					lualine_z = {
						{ "location", separator = { right = "" }, left_padding = 2 },
					},
				},
			})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				highlights = {
					background = {
						fg = "#596276",
					},
					close_button = {
						fg = "#596276",
					},
					buffer_visible = {
						fg = "#596276",
					},
				},
			})
			vim.keymap.set("n", "<leader>bn", ":BufferLineMoveNext<CR>")
			vim.keymap.set("n", "<leader>bp", ":BufferLineMovePrev<CR>")
		end,
	},
	-- {
	-- 	"stevearc/aerial.nvim",
	-- 	opts = {},
	-- 	-- Optional dependencies
	-- 	dependencies = {
	-- 		"nvim-treesitter/nvim-treesitter",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 	},
	-- 	config = function()
	-- 		require("aerial").setup({
	-- 			backends = { "lsp" },
	-- 			filter_kind = { "Function", "Constant" },
	-- 			layout = {
	-- 				default_direction = "prefer_left",
	-- 				min_width = 30,
	-- 			},
	-- 			open_automatic = false,
	-- 			highlight_on_jump = false,
	-- 			-- optionally use on_attach to set keymaps when aerial has attached to a buffer
	-- 			on_attach = function(bufnr)
	-- 				-- Jump forwards/backwards with '{' and '}'
	-- 				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
	-- 				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
	-- 			end,
	-- 		})
	-- 		-- You probably also want to set a keymap to toggle aerial
	-- 		vim.keymap.set("n", "<leader>s", "<cmd>AerialToggle!<CR>")
	-- 	end,
	-- },
	{
		"lukas-reineke/indent-blankline.nvim",
		enabled = false,
		main = "ibl",
		config = function()
			local github_dark_dimmed = {
				"github_dark_dimmed",
			}
			local tokyonight_day = {
				"tokyonight_day",
			}
			local solarized_light = {
				"solarized_light",
			}
			local github_light = {
				"github_light",
			}
			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "github_dark_dimmed", { fg = "#31363B" })
				vim.api.nvim_set_hl(0, "github_light", { fg = "#E1E2E4" })
				vim.api.nvim_set_hl(0, "tokyonight_day", { fg = "#D1D3E6" })
				vim.api.nvim_set_hl(0, "solarized_light", { fg = "#EEE8D5" })
				vim.api.nvim_set_hl(0, "solarized_light", { fg = "#EEE8D5" })
			end)
			require("ibl").setup({
				scope = {
					enabled = false,
				},
				indent = {
					-- highlight = github_light,
				},
				exclude = {
					filetypes = { "dashboard", "sql", "dbout" },
				},
			})
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-highlight-colors").setup({
				enable_tailwind = true,
			})
		end,
	},
	-- {
	-- 	"glepnir/dashboard-nvim",
	-- 	config = function()
	-- 		local custom_header = {
	-- 			[[                                                                       ]],
	-- 			[[                                                                       ]],
	-- 			[[                                                                       ]],
	-- 			[[                                                                       ]],
	-- 			[[                                                                       ]],
	-- 			[[  ██████   █████                   █████   █████  ███                  ]],
	-- 			[[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
	-- 			[[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
	-- 			[[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
	-- 			[[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
	-- 			[[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
	-- 			[[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
	-- 			[[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
	-- 			[[                                                                       ]],
	-- 			[[                                                                       ]],
	-- 			[[                                                                       ]],
	-- 		}
	-- 		local custom_center = {
	-- 			{
	-- 				icon = "  ",
	-- 				desc = "Find files                     ",
	-- 				key = "SPC p",
	-- 				action = function()
	-- 					require("telescope.builtin").find_files({ previewer = false })
	-- 				end,
	-- 			},
	-- 			{
	-- 				icon = "  ",
	-- 				desc = "Open explorer                  ",
	-- 				key = "SPC e",
	-- 				action = ":NvimTreeToggle<CR>",
	-- 			},
	-- 			{
	-- 				icon = "  ",
	-- 				desc = "Find word                     ",
	-- 				key = "SPC f w",
	-- 				action = function()
	-- 					require("telescope.builtin").live_grep()
	-- 				end,
	-- 			},
	-- 			{
	-- 				icon = "  ",
	-- 				desc = "Find recent files             ",
	-- 				key = "SPC f r",
	-- 				action = function()
	-- 					require("telescope.builtin").oldfiles()
	-- 				end,
	-- 			},
	-- 		}
	-- 		local custom_footer = {
	-- 			[[ ]],
	-- 			[[ ]],
	-- 			"One day at a time  ",
	-- 		}
	-- 		require("dashboard").setup({
	-- 			theme = "doom",
	-- 			config = {
	-- 				header = custom_header,
	-- 				center = custom_center,
	-- 				footer = custom_footer,
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
