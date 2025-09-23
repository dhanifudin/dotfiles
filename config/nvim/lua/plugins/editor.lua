return {
  {
    "Julian/vim-textobj-variable-segment",
    dependencies = {
      { "kana/vim-textobj-user" },
    },
  },
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
    "nvim-mini/mini.align",
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
