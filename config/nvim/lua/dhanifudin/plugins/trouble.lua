return {
  "folke/trouble.nvim",
  event = "VeryLazy",
  config = function()
    require("trouble").setup({})
  end,
}