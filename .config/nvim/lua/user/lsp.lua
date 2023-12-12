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
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
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
  filetypes = { "html", "heex", "elixir", "astro" },
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
