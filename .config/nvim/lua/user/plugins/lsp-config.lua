return {
	{
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
				on_attach = function(client)
					client.resolved_capabilities.documentFormatingProvider = false
				end,
			})

			lspconfig.tsserver.setup({
				capabilities = capabilities,
				on_attach = function(client)
					client.resolved_capabilities.documentFormatingProvider = false
				end,
			})

			lspconfig.html.setup({
				capabilities = capabilities,
				filetypes = { "html", "svg" },
				on_attach = function(client)
					client.resolved_capabilities.documentFormatingProvider = false
				end,
			})

			lspconfig.jsonls.setup({
				filetypes = { "json", "jsonc", "tpl" },
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
					},
				},
				capabilities = capabilities,
			})

			lspconfig.tailwindcss.setup({})

			lspconfig.yamlls.setup({
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
				filetypes = { "terraform", "tf", "terraformvars", "tfvars" },
			})

			-- lspconfig.dockerls.setup({})
			-- lspconfig.docker_compose_language_service.setup({
			-- 	root_dir = lspconfig.util.root_pattern("docker-compose.yml", "docker-compose.yaml"),
			-- })

			-- lspconfig.elixirls.setup({
			-- 	cmd = { vim.fn.expand("~/.config/elixir_ls/language_server.sh") },
			-- })
			--
			-- lspconfig.angularls.setup({
			-- 	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
			-- })

			-- lspconfig.gopls.setup({})
			-- lspconfig.omnisharp.setup({})

			-- vim.api.nvim_create_autocmd({ "BufWritePre" }, {
			-- 	pattern = { "*.tf", "*.tfvars" },
			-- 	callback = function()
			-- 		vim.lsp.buf.format()
			-- 	end,
			-- })

			vim.keymap.set("n", "<space>d", vim.diagnostic.open_float)
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
					-- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					-- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
					-- vim.keymap.set("n", "<space>wl", function()
					--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					-- end, opts)
					-- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
					-- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) // replaced with telescope
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
								filter = function(c)
									return c.name == "null-ls"
								end,
							})
						end,
					})
				end
			end

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier.with({
						extra_filetypes = {
							"astro",
							"svelte",
							"telekasten",
						},
					}),
					-- null_ls.builtins.formatting.prettierd.with({
					-- 	env = {
					-- 		PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/utils/.prettierrc"),
					-- 	},
					-- 	extra_filetypes = {
					-- 		"astro",
					-- 		"svelte",
					-- 	},
					-- }),
					null_ls.builtins.formatting.terraform_fmt,
					null_ls.builtins.formatting.sql_formatter,
				},
				on_attach = format_on_save,
			})

			vim.filetype.add({
				extension = {
					tpl = "tpl",
				},
			})

			vim.treesitter.language.register("json", "tpl")
		end,
	},
	{
		"elixir-tools/elixir-tools.nvim",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
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
		end,
	},
}
