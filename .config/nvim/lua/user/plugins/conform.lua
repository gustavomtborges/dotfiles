return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				prettierd = {
					env = {
						PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/utils/.prettierrc"),
					},
				},
				sql_formatter = {
					args = "-l postgresql",
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				go = { { "goimports-reviser", "gofumpt" } },
				templ = { "templ" },
				sql = { "sql_formatter" },
				html = { { "prettier", "prettierd" } },
				svelte = { { "prettier", "prettierd" } },
				javascript = { { "prettier", "prettierd" } },
				typescript = { { "prettier", "prettierd" } },
				css = { { "prettier", "prettierd" } },
				json = { { "prettier", "prettierd" } },
				markdown = { { "prettier", "prettierd" } },
				yaml = { { "prettier", "prettierd" } },
				telekasten = { { "prettier", "prettierd" } },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				async = false,
				lsp_fallback = true,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>l", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
