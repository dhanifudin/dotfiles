return {
  {
    "aserowy/tmux.nvim",
    event = "VeryLazy",
    keys = {
      { "<C-h>", "<cmd>lua require('tmux').move_left()<cr>", desc = "Move to left pane" },
      { "<C-j>", "<cmd>lua require('tmux').move_bottom()<cr>", desc = "Move to bottom pane" },
      { "<C-k>", "<cmd>lua require('tmux').move_top()<cr>", desc = "Move to top pane" },
      { "<C-l>", "<cmd>lua require('tmux').move_right()<cr>", desc = "Move to right pane" },
    },
    opts = {
      copy_sync = {
        enable = true,
        sync_clipboard = true,
        sync_registers = true,
      },
      navigation = {
        enable_default_keybindings = true,
        cycle_navigation = true,
      },
      resize = {
        enable_default_keybindings = true,
        resize_step_x = 2,
        resize_step_y = 2,
      },
    },
  },
}
