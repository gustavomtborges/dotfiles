return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"b0o/schemastore.nvim",
			"nanotee/sqls.nvim",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"templ",
					"marksman",
					"tsserver",
					"jsonls",
					"html",
					"terraformls",
				},
			})
			local lspconfig = require("lspconfig")
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

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
				capabilities = capabilities,
			})

			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})

			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = { "html", "svg", "templ" },
			})

			lspconfig.jsonls.setup({
				filetypes = { "json", "jsonc", "tpl" },
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
				capabilities = capabilities,
			})

			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
				filetypes = { "templ", "astro", "svelte" },
				init_options = { userLanguages = { templ = "html" } },
			})

			lspconfig.yamlls.setup({
				settings = {
					yaml = {
						schemaStore = {
							-- You must disable built-in schemaStore support if you want to use
							-- this plugin and its advanced options like `ignore`.
							enable = false,
							-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				},
				capabilities = capabilities,
			})

			lspconfig.astro.setup({
				capabilities = capabilities,
			})

			lspconfig.svelte.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							-- Here use ctx.match instead of ctx.file
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
						end,
					})
				end,
			})

			lspconfig.marksman.setup({
				capabilities = capabilities,
				on_attach = function(client)
					client.resolved_capabilities.documentFormatingProvider = false
				end,
			})

			lspconfig.ansiblels.setup({
				capabilities = capabilities,
			})

			lspconfig.terraformls.setup({
				capabilities = capabilities,
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
			})

			lspconfig.templ.setup({
				capabilities = capabilities,
			})
			vim.filetype.add({ extension = { templ = "templ" } })

			lspconfig.sqls.setup({
				on_attach = function(client, bufnr)
					require("sqls").on_attach(client, bufnr) -- require sqls.nvim
				end,
			})

			lspconfig.helm_ls.setup({
				capabilities = capabilities,
			})

			vim.keymap.set("n", "<leader>td", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

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
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>h", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>cf", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})

			local _border = "rounded"

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = _border,
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = _border,
			})

			vim.diagnostic.config({
				float = { border = _border },
			})

			vim.filetype.add({
				extension = {
					tpl = "tpl",
				},
			})

			vim.treesitter.language.register("json", "tpl")
		end,
	},
}
