require("nvim-autopairs").setup({})
require("Comment").setup()

require("nvim-ts-autotag").setup({
	filetypes = { "html", "heex", "astro" },
})

require("git-conflict").setup({
	default_mappings = {
		next = "]x",
		prev = "[x",
	},
})
require("gitsigns").setup()
require("nvim-surround").setup()

-- nvim-cmp setup
local luasnip = require("luasnip")
local lspkind = require("lspkind")
vim.opt.completeopt = { "menu", "menuone", "noselect" }
require("luasnip.loaders.from_vscode").lazy_load()
local cmp = require("cmp")
if cmp then
	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		sources = {
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "path" },
		},
		mapping = cmp.mapping.preset.insert({
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			}),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				symbol_map = {
					Unit = " ",
				},
				menu = {
					nvim_lsp = "[LSP]",
					nvim_lua = "[Lua]",
					luasnip = "[Snippet]",
					path = "[Path]",
					buffer = "[Buffer]",
				},
			}),
		},
	})

	-- cmp.setup.cmdline("/", {
	-- 	mapping = cmp.mapping.preset.cmdline(),
	-- 	sources = {
	-- 		{ name = "buffer" },
	-- 	},
	-- })
end
