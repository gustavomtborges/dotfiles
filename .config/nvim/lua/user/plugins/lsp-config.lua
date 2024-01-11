return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"b0o/schemastore.nvim",
		"nvimtools/none-ls.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup()
		local lspconfig = require("lspconfig")

		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					runtime = {
						-- Tell the language server which version of Lua you're using
						-- (most likely LuaJIT in the case of Neovim)
						version = "LuaJIT",
					},
					diagnostics = { globals = "vim" },
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
			},
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

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				-- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
				-- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
				-- vim.keymap.set("n", "<space>wl", function()
				--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				-- end, opts)
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<space>cf", function()
					vim.lsp.buf.format({ async = true })
				end, opts)
			end,
		})

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
	end,
}
