return {
  -- Auto-pairs
  {
    "nvim-mini/mini.pairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Surround (vim-surround style: ys/ds/cs in normal, S in visual)
  {
    "nvim-mini/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add            = "ys",
        delete         = "ds",
        replace        = "cs",
        find           = "",
        find_left      = "",
        highlight      = "",
        update_n_lines = "",
      },
    },
    config = function(_, opts)
      require("mini.surround").setup(opts)
      -- S in visual mode mirrors vim-surround (flash gives up visual S above)
      vim.keymap.set("x", "S", function()
        return require("mini.surround").add("visual")
      end, { expr = true, desc = "Surround selection" })
      -- yss to surround current line (vim-surround compat)
      vim.keymap.set("n", "yss", "ys_", { remap = true, desc = "Surround line" })
    end,
  },

  -- Variable segment text objects (iv = inner, av = around)
  {
    "variable-segment-textobj",
    dir = vim.fn.stdpath("config"),
    name = "variable-segment-textobj",
    event = "VeryLazy",
    config = function()
      require("util.variable_segment").setup()
    end,
  },
}
