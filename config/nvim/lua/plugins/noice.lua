return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-mini/mini.icons",
    },
    opts = {
      lsp = {
        -- Use noice for LSP progress, override handlers
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
        hover    = { enabled = true },
        signature = { enabled = false }, -- blink.cmp handles signature
        progress = { enabled = true },
      },
      presets = {
        bottom_search        = true,  -- search cmdline at bottom
        command_palette      = true,  -- cmdline + popupmenu as palette
        long_message_to_split = true, -- long messages go to split
        inc_rename           = false,
        lsp_doc_border       = true,  -- border on hover/signature docs
      },
      routes = {
        -- Suppress common noisy messages
        { filter = { event = "msg_show", find = "written" },          opts = { skip = true } },
        { filter = { event = "msg_show", find = "%d+ lines" },        opts = { skip = true } },
        { filter = { event = "msg_show", find = "search hit BOTTOM" }, opts = { skip = true } },
        { filter = { event = "msg_show", find = "search hit TOP" },    opts = { skip = true } },
      },
    },
    keys = {
      { "<leader>un", function() require("noice").cmd("history") end,  desc = "Notification history" },
      { "<leader>ud", function() require("noice").cmd("dismiss") end,  desc = "Dismiss notifications" },
      { "<leader>ul", function() require("noice").cmd("last") end,     desc = "Last message" },
      { "<S-Enter>",  function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect cmdline" },
    },
  },
}
