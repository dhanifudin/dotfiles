local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim", opt = true })
	use({ "lewis6991/impatient.nvim", config = [[require('impatient')]] })

	use({ "onsails/lspkind-nvim" })

	use({ "gruvbox-community/gruvbox" })
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "svermeulen/vim-easyclip" })
	use({ "editorconfig/editorconfig-vim" })
	use({ "voldikss/vim-floaterm" })
	use({ "mbbill/undotree" })
	use({ "towolf/vim-helm" })

	-- auto-completion engine
	use({ "neovim/nvim-lspconfig" })
	use({ "hrsh7th/nvim-cmp" })
	use({ "tami5/lspsaga.nvim" })
	use({ "github/copilot.vim" })

	-- nvim-cmp completion sources
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-vsnip" })
	use({ "hrsh7th/vim-vsnip" })
	use({ "akinsho/flutter-tools.nvim" })
	use({ "rafamadriz/friendly-snippets" })

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use({ "wakatime/vim-wakatime" })
	use({ "tpope/vim-vinegar" })

	use({
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("gitsigns").setup()
		end,
	})

	use({ "nvim-telescope/telescope-file-browser.nvim" })

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use({ "windwp/nvim-autopairs" })
	use({ "windwp/nvim-ts-autotag" })

	use({ "tpope/vim-commentary" })
	use({ "tpope/vim-dadbod" })
	use({ "tpope/vim-dispatch" })
	use({ "tpope/vim-dotenv" })
	use({ "tpope/vim-fugitive" })
	use({ "tpope/vim-projectionist" })
	use({ "tpope/vim-repeat" })
	use({ "tpope/vim-surround" })
	use({ "tpope/vim-unimpaired" })

	use({ "junegunn/vim-easy-align" })
	use({ "mhartington/formatter.nvim" })

	use({ "christoomey/vim-tmux-navigator" })

	use({
		"Julian/vim-textobj-variable-segment",
		requires = { "kana/vim-textobj-user" },
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)