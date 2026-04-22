return {
  -- Flash.nvim - fast motion
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash jump" },
      { "S", function() require("flash").treesitter() end, mode = { "n", "o" }, desc = "Flash treesitter" },
      { "r", function() require("flash").remote() end, mode = "o", desc = "Flash remote" },
      { "R", function() require("flash").treesitter_search() end, mode = { "o", "x" }, desc = "Flash treesitter search" },
    },
  },

  -- Oil.nvim - file explorer as buffer
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-mini/mini.icons" },
    keys = {
      { "<leader>e", "<cmd>Oil<cr>", desc = "File explorer" },
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<CR>"] = "actions.select",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["q"] = "actions.close",
        ["<C-s>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-r>"] = "actions.refresh",
        ["g."] = "actions.toggle_hidden",
        ["g?"] = "actions.show_help",
      },
      use_default_keymaps = false,
    },
  },
}
