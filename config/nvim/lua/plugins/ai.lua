return {
  -- OpenCode integration for VS Code
  {
    "sudo-tee/opencode.nvim",
    cmd = { "OpenCode", "OpenCodeFile" },
    keys = {
      {
        "<leader>ao",
        "<cmd>Opencode<cr>",
        desc = "Open Code (current file)",
      },
    },
    opts = {
      command = "code",
      open_in_new_window = false,
      wait = false,
    },
    config = function(_, opts)
      require("opencode").setup(opts)
    end,
  },

  -- Claude Code customization - position at bottom
  {
    "coder/claudecode.nvim",
    optional = true,
    opts = {
      terminal = {
        snacks_win_opts = {
          position = "bottom", -- Display at bottom like a drawer
          height = 0.4, -- 40% of screen height
          width = 1.0, -- Full width
          border = "rounded",
        },
      },
    },
  },
}
