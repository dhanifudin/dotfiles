local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

local status, lazy = pcall(require, "lazy")
if not status then
	return
end

local plugins = {}

if vim.g.vscode == nil then
	plugins = {
		"nvim-lua/plenary.nvim",
		"gruvbox-community/gruvbox",
		"lukas-reineke/indent-blankline.nvim",
		"svermeulen/vim-easyclip",
		"editorconfig/editorconfig-vim",
		{ "voldikss/vim-floaterm", cmd = "FloatermNew" },
		{ "mbbill/undotree", cmd = "UndotreeToggle" },
		{ "towolf/vim-helm", ft = "yaml" },

		"neovim/nvim-lspconfig",
		"glepnir/lspsaga.nvim",

		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-vsnip",
				"hrsh7th/vim-vsnip",
				"rafamadriz/friendly-snippets",
			},
		},
		"mfussenegger/nvim-dap",
		"leoluz/nvim-dap-go",

		"nvim-treesitter/nvim-treesitter",

		"wakatime/vim-wakatime",
		"phaazon/hop.nvim",

		{
			"nvim-telescope/telescope.nvim",
			lazy = true,
			dependencies = {
				"nvim-telescope/telescope-file-browser.nvim",
			},
		},

		{
			"simrat39/symbols-outline.nvim",
			cmd = "SymbolsOutline",
			config = function()
				require("symbols-outline").setup()
			end,
		},

		{
			"lewis6991/gitsigns.nvim",
			config = function()
				require("gitsigns").setup()
			end,
		},

		{
			"folke/zen-mode.nvim",
			config = function()
				require("zen-mode").setup({
					{
						window = {
							backdrop = 0.8,
							options = {
								signcolumn = "no",
								number = false,
								relativenumber = false,
								cursorline = true,
								foldcolumn = "0",
								list = false,
							},
						},
						plugins = {
							tmux = { enabled = true },
							kitty = {
								enabled = true,
								font = "+2",
							},
						},
					},
				})
			end,
		},
		"nvim-lualine/lualine.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-tree/nvim-tree.lua",

		"windwp/nvim-autopairs",
		"windwp/nvim-ts-autotag",

		{
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		},

		"tpope/vim-dadbod",
		"tpope/vim-dispatch",
		"tpope/vim-dotenv",
		"tpope/vim-fugitive",
		"tpope/vim-projectionist",
		"tpope/vim-repeat",
		"tpope/vim-surround",
		"tpope/vim-unimpaired",
		"tpope/vim-vinegar",

		{ "junegunn/vim-easy-align", lazy = true },
		{ "mhartington/formatter.nvim", lazy = true },
		"christoomey/vim-tmux-navigator",

		{
			"Julian/vim-textobj-variable-segment",
			dependencies = {
				"kana/vim-textobj-user",
			},
		},

		{ "monaqa/dial.nvim", keys = { "<C-a>", "<C-x>" } },
		{
			"iamcco/markdown-preview.nvim",
			ft = "markdown",
			config = function()
				vim.fn["mkdp#util#install"]()
			end,
		},
	}
else
	plugins = {
		"svermeulen/vim-easyclip",
		"mbbill/undotree",
		"asvetliakov/vim-easymotion",
		"tpope/vim-repeat",
		"tpope/vim-surround",
		"tpope/vim-unimpaired",
		{
			"Julian/vim-textobj-variable-segment",
			dependencies = {
				"kana/vim-textobj-user",
			},
		},
	}
	vim.cmd([[
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1

  nmap s <Plug>(easymotion-s)
  omap s <Plug>(easymotion-s)
  xmap s <Plug>(easymotion-s)

  xmap gc  <Plug>VSCodeCommentary
  nmap gc  <Plug>VSCodeCommentary
  omap gc  <Plug>VSCodeCommentary
  nmap gcc <Plug>VSCodeCommentaryLine
]])
end

lazy.setup({ plugins })
