return {
  {
    "aserowy/tmux.nvim",
    keys = {
      {
        "<C-h>",
        function()
          require("tmux").move_left()
        end,
        desc = "tmux move left",
      },
      {
        "<C-j>",
        function()
          require("tmux").move_bottom()
        end,
        desc = "tmux move bottom",
      },
      {
        "<C-k>",
        function()
          require("tmux").move_top()
        end,
        desc = "tmux move top",
      },
      {
        "<C-l>",
        function()
          require("tmux").move_right()
        end,
        desc = "tmux move right",
      },
    },
    opts = {
      navigation = {
        enable_default_keybindings = false,
      },
    },
  },
  { "tpope/vim-vinegar" },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        char = {
          jump_labels = true,
        },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false,
  },
}
