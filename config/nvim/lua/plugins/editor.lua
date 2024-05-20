return {
  {
    "tummetott/unimpaired.nvim",
    event = 'VeryLazy',
  },
  "tpope/vim-dispatch",
  {
    "ellisonleao/glow.nvim",
    opts = function()
      require("glow").setup()
    end,
  },
}
