require("mason").setup()
require("mason-lspconfig").setup()
local lspconfig = require("lspconfig")

local elixirls = require("elixir.elixirls")
require("elixir").setup({
	nextls = { enable = false },
	credo = { enable = false },
	elixirls = {
		settings = elixirls.settings({
			dialyzerEnabled = false,
			enableTestLenses = false,
		}),
	},
})

lspconfig.lua_ls.setup({
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
			client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					-- Make the server aware of Neovim runtime files
					workspace = {
						checkThirdParty = false,
						library = {
							vim.env.VIMRUNTIME,
							-- "${3rd}/luv/library"
							-- "${3rd}/busted/library",
						},
						-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
						-- library = vim.api.nvim_get_runtime_file("", true)
					},
				},
			})

			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
		end
		return true
	end,
})

lspconfig.cssls.setup({
	settings = {
		scss = {
			lint = {
				idSelector = "warning",
				zeroUnits = "warning",
				duplicateProperties = "warning",
			},
			completion = {
				completePropertyWithSemicolon = true,
				triggerPropertyValueCompletion = true,
			},
		},
	},
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
})

lspconfig.tsserver.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
})

lspconfig.html.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
})

lspconfig.angularls.setup({
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
})

lspconfig.jsonls.setup({
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
		},
	},
	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
})

lspconfig.tailwindcss.setup({
	filetypes = { "html", "heex", "elixir", "astro", "cshtml" },
	init_options = {
		userLanguages = {
			elixir = "html-eex",
			eelixir = "html-eex",
			heex = "html-eex",
		},
	},
})

lspconfig.dockerls.setup({})
-- lspconfig.docker_compose_language_service.setup({
-- 	root_dir = lspconfig.util.root_pattern("docker-compose.yml", "docker-compose.yaml"),
-- })
lspconfig.yamlls.setup({})
lspconfig.prismals.setup({})
lspconfig.astro.setup({})
-- lspconfig.elixirls.setup({
-- 	cmd = { vim.fn.expand("~/.config/elixir_ls/language_server.sh") },
-- })
lspconfig.ansiblels.setup({})
lspconfig.terraformls.setup({
	filetypes = { "terraform", "tf", "terraformvars", "tfvars" },
})
lspconfig.gopls.setup({})
lspconfig.omnisharp.setup({})

-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
-- 	pattern = { "*.tf", "*.tfvars" },
-- 	callback = function()
-- 		vim.lsp.buf.format()
-- 	end,
-- })

local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local format_on_save = function(client, bufnr)
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					bufnr = bufnr,
					-- filter = function(c)
					-- 	return c.name == "null-ls"
					-- end,
				})
			end,
		})
	end
end

null_ls.setup({
	sources = {
		null_ls.builtins.completion.spell,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.xmllint,
		null_ls.builtins.formatting.prettierd.with({
			extra_filetypes = {
				"telekasten",
				"txt",
				"config",
				"astro",
			},
		}),
		null_ls.builtins.formatting.rubyfmt,
		null_ls.builtins.formatting.terraform_fmt,
		null_ls.builtins.diagnostics.jsonlint,
		null_ls.builtins.diagnostics.golangci_lint,
	},
	on_attach = format_on_save,
})

vim.filetype.add({
	extension = {
		mdx = "mdx",
	},
})

vim.treesitter.language.register("typescript", "mdx")
