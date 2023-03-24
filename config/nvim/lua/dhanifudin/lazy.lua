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
      require("dhanifudin.plugins.gruvbox"),
      require("dhanifudin.plugins.blankline"),
      "svermeulen/vim-cutlass",
      require("dhanifudin.plugins.yoink"),
      "editorconfig/editorconfig-vim",
      "mbbill/undotree",
      -- require("dhanifudin.plugins.lspsaga"),
      require("dhanifudin.plugins.completion"),

      "mfussenegger/nvim-dap",
      "leoluz/nvim-dap-go",

      require("dhanifudin.plugins.treesitter"),

      "wakatime/vim-wakatime",
      require("dhanifudin.plugins.hop"),
      require("dhanifudin.plugins.telescope"),
      require("dhanifudin.plugins.todo-comments"),
      require("dhanifudin.plugins.symbols-outline"),

      "lewis6991/gitsigns.nvim",
      "folke/zen-mode.nvim",
      "nvim-lualine/lualine.nvim",
      "nvim-tree/nvim-web-devicons",

      require("dhanifudin.plugins.comment"),
      "tpope/vim-dadbod",
      "tpope/vim-dispatch",
      "tpope/vim-dotenv",
      "tpope/vim-fugitive",
      "tpope/vim-projectionist",
      "tpope/vim-repeat",
      "tpope/vim-surround",
      "tpope/vim-unimpaired",
      "tpope/vim-vinegar",

      "junegunn/vim-easy-align",
      { "mhartington/formatter.nvim", lazy = true },
      "christoomey/vim-tmux-navigator",

      require("dhanifudin.plugins.dial"),
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
