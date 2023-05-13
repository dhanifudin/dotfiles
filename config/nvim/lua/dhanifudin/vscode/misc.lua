return {
  "tpope/vim-repeat",
  "tpope/vim-unimpaired",
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
}