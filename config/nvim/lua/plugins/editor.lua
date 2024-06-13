return {
  {
    "tummetott/unimpaired.nvim",
    event = "VeryLazy",
    opts = function()
      require("unimpaired").setup()
    end,
  },
  "tpope/vim-dispatch",
  {
    "ellisonleao/glow.nvim",
    opts = function()
      require("glow").setup()
    end,
  },
  {
    "echasnovski/mini.comment",
    event = "BufRead",
    opts = function()
      require("mini.comment").setup({
        mappings = {
          comment = "gc",
          comment_line = "gcc",
          comment_visual = "gc",
          textobject = "gc",
        },
      })
    end,
  }
}
