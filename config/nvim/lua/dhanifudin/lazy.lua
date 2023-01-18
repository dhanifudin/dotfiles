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

if status then
	local plugins = {}
	if vim.g.vscode == nil then
		plugins = {
			"nvim-lua/plenary.nvim",
			"gruvbox-community/gruvbox",
			"lukas-reineke/indent-blankline.nvim",
			"svermeulen/vim-cutlass",
			require("dhanifudin.plugins.yoink"),
			"editorconfig/editorconfig-vim",
			"mbbill/undotree",
			"neovim/nvim-lspconfig",
			require("dhanifudin.plugins.lspsaga"),
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
			require("dhanifudin.plugins.hop"),
			require("dhanifudin.plugins.telescope"),
			require("dhanifudin.plugins.todo-comments"),

			{
				"simrat39/symbols-outline.nvim",
				cmd = "SymbolsOutline",
				config = function()
					require("symbols-outline").setup()
				end,
			},

			"lewis6991/gitsigns.nvim",
			"folke/zen-mode.nvim",
			"nvim-lualine/lualine.nvim",
			"nvim-tree/nvim-web-devicons",

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

			{ "monaqa/dial.nvim", keys = { "<C-a>", "<C-x>" } },
			require("dhanifudin.plugins.textobject"),
			require("dhanifudin.plugins.markdown"),
			require("dhanifudin.plugins.filetypes"),
		}
	else
		plugins = {
			require("dhanifudin.plugins.easymotion"),
			require("dhanifudin.plugins.textobject"),
			require("dhanifudin.plugins.yoink"),
			"svermeulen/vim-cutlass",
			"tpope/vim-repeat",
			"tpope/vim-surround",
			"tpope/vim-unimpaired",
		}
		vim.keymap.set({ "n", "o", "x" }, "gc", "<Plug>VSCodeCommentary")
		vim.keymap.set("n", "gcc", "<Plug>VSCodeCommentaryLine")
	end

	lazy.setup({ plugins })
end
