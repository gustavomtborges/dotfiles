local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
end

vim.cmd([[packadd packer.nvim]])
-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- UI
	use("kyazdani42/nvim-web-devicons")
	-- Status bar
	use({ "nvim-lualine/lualine.nvim", requires = "kyazdani42/nvim-web-devicons" })
	use("arkav/lualine-lsp-progress")
	-- Buffer bar
	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })
	-- Git gutter
	use("lewis6991/gitsigns.nvim")
	-- Smooth scroll
	use("karb94/neoscroll.nvim")
	-- Colorizer Hex
	use("norcalli/nvim-colorizer.lua")
	-- Diagnostics msgs
	use("folke/trouble.nvim")
	-- Dashboard
	use("glepnir/dashboard-nvim")
	use("lukas-reineke/indent-blankline.nvim")

	-- Tree explorer
	use("kyazdani42/nvim-tree.lua")
	use("simrat39/symbols-outline.nvim")

	-- Colorschemes
	use("navarasu/onedark.nvim")
	use("folke/tokyonight.nvim")
	use("ellisonleao/gruvbox.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("sainnhe/everforest")
	use("projekt0n/github-nvim-theme")
	use("EdenEast/nightfox.nvim")
	use("sainnhe/edge")
	use("Mofiqul/adwaita.nvim")
	use("sainnhe/sonokai")
	use("maxmx03/solarized.nvim")
	use("Mofiqul/vscode.nvim")

	-- Language support
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("b0o/schemastore.nvim")
	use("nvimtools/none-ls.nvim")
	use({ "elixir-tools/elixir-tools.nvim", tag = "stable", requires = { "nvim-lua/plenary.nvim" } })
	-- Java
	use("mfussenegger/nvim-jdtls")
	-- Debug
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")

	-- Editor utils
	use({
		"kylechui/nvim-surround",
		tag = "*",
	})
	use("tpope/vim-fugitive")
	use("windwp/nvim-autopairs")
	use("numToStr/Comment.nvim")
	use("windwp/nvim-ts-autotag")
	use({ "akinsho/git-conflict.nvim", tag = "*" })
	use("folke/which-key.nvim")
	use("nvimdev/lspsaga.nvim")
	use("famiu/bufdelete.nvim")
	-- Auto completion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")
	use("onsails/lspkind.nvim")

	-- File explorer
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- Note-taking
	use("renerocksai/telekasten.nvim")
	use("renerocksai/calendar-vim")
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})
	use("nvim-telescope/telescope-media-files.nvim")

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
