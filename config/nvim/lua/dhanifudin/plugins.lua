local fn = vim.fn

local packer_install_dir = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local plug_url_format = 'https://github.com/%s'

local packer_repo = string.format(plug_url_format, 'wbthomason/packer.nvim')
local install_cmd = string.format('10split | term git clone --depth=1 %s %s', packer_repo, packer_install_dir)

if fn.empty(fn.glob(packer_install_dir)) > 0 then
  vim.api.nvim_echo({{'Installing packer.nvim', 'Type'}}, true, {})
  vim.cmd(install_cmd)
end

vim.cmd("packadd packer.nvim")

require("packer").startup(function(use)
  use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}

  use({"wbthomason/packer.nvim", opt = true})
  use({"onsails/lspkind-nvim"})

  use {"gruvbox-community/gruvbox"}
  use {"svermeulen/vim-cutlass"}
  use {"svermeulen/vim-yoink"}
  use {"editorconfig/editorconfig-vim"}
  use {"voldikss/vim-floaterm"}

  use {
    "nvim-telescope/telescope.nvim",
    requires = {{'nvim-lua/plenary.nvim'}}
  }
  use {"nvim-telescope/telescope-file-browser.nvim"}
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ':TSUpdate'
  }
  -- auto-completion engine
  use { "neovim/nvim-lspconfig" }
  use {"hrsh7th/nvim-cmp"}

  -- nvim-cmp completion sources
  use {"hrsh7th/cmp-nvim-lsp"}
  use {"hrsh7th/cmp-nvim-lua"}
  use {"hrsh7th/cmp-path"}
  use {"hrsh7th/cmp-buffer"}
  use {"hrsh7th/cmp-vsnip"}
  use {"hrsh7th/vim-vsnip"}
  use {"akinsho/flutter-tools.nvim"}

  use {"vim-airline/vim-airline"}
  use {"vim-airline/vim-airline-themes"}

  use {"windwp/nvim-autopairs"}
  use {"windwp/nvim-ts-autotag", after = "nvim-treesitter"}

  use {"tpope/vim-commentary"}
  use {"tpope/vim-dadbod"}
  use {"tpope/vim-dispatch"}
  use {"tpope/vim-dotenv"}
  use {"tpope/vim-fugitive"}
  use {"tpope/vim-projectionist"}
  use {"tpope/vim-repeat"}
  use {"tpope/vim-surround"}
  use {"tpope/vim-unimpaired"}
  use {"tpope/vim-vinegar"}

  use {"christoomey/vim-tmux-navigator"}
  use {"easymotion/vim-easymotion"}
  use {"wakatime/vim-wakatime"}
end)