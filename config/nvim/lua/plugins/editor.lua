return {
  {
    "tummetott/unimpaired.nvim",
    event = "VeryLazy",
    opts = function()
      require("unimpaired").setup()
    end,
  },
  {
    "tpope/vim-dispatch",
    config = function()
      vim.keymap.set("n", "!", ":Dispatch ", { noremap = true, silent = true })
    end,
  },
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
  },
  {
    "echasnovski/mini.align",
    event = "BufRead",
    opts = function()
      require("mini.align").setup({
        mappings = {
          start = "ga",
        },
      })
    end,
  },
}
