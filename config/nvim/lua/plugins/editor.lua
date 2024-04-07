return {
  "tpope/vim-unimpaired",
  "tpope/vim-dispatch",
  {
    "ellisonleao/glow.nvim",
    opts = function()
      require("glow").setup()
    end,
  },
}
