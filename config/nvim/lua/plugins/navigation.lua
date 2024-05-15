return {
  {
    "aserowy/tmux.nvim",
    keys = {
      { "<C-h>", function() require("tmux").move_left() end, desc = "tmux move left" },
      { "<C-j>", function() require("tmux").move_bottom() end, desc = "tmux move bottom" },
      { "<C-k>", function() require("tmux").move_top() end, desc = "tmux move top" },
      { "<C-l>", function() require("tmux").move_right() end, desc = "tmux move right" },
    },
    opts = {
      navigation = {
        enable_default_keybindings = false,
      },
    },
  },
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
    opts = {
      window = {
        position = "left",
        width = 20,
      },
    },
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local oil = require("oil")
      oil.setup {
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<M-h>"] = "actions.select_split",
        },
        view_options = {
          show_hidden = true,
        },
      }

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      vim.keymap.set("n", "<space>-", oil.toggle_float)
    end
  }
}
