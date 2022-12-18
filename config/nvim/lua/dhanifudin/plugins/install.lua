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

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost install.lua source <afile> | PackerInstall
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })
	use({ "lewis6991/impatient.nvim" })
	use({ "nvim-lua/plenary.nvim" })

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
	use({ "onsails/lspkind-nvim" })
	use({ "kkharji/lspsaga.nvim" })

	-- nvim-cmp completion sources
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-vsnip" })
	use({ "hrsh7th/vim-vsnip" })
	use({ "rafamadriz/friendly-snippets" })

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	use({ "wakatime/vim-wakatime" })
	use({ "phaazon/hop.nvim" })

	use({ "nvim-telescope/telescope.nvim" })
	use({ "nvim-telescope/telescope-file-browser.nvim" })

	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	use({ "windwp/nvim-autopairs" })
	use({ "windwp/nvim-ts-autotag" })

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use({ "tpope/vim-dadbod" })
	use({ "tpope/vim-dispatch" })
	use({ "tpope/vim-dotenv" })
	use({ "tpope/vim-fugitive" })
	use({ "tpope/vim-projectionist" })
	use({ "tpope/vim-repeat" })
	use({ "tpope/vim-surround" })
	use({ "tpope/vim-unimpaired" })
	use({ "tpope/vim-vinegar" })

	use({ "junegunn/vim-easy-align" })
	use({ "mhartington/formatter.nvim" })

	use({ "christoomey/vim-tmux-navigator" })

	use({
		"Julian/vim-textobj-variable-segment",
		requires = { "kana/vim-textobj-user" },
	})

	use({ "monaqa/dial.nvim" })
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	if packer_bootstrap then
		require("packer").install()
	end
end)
