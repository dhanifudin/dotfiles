return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- Performance: disable features on large files
      bigfile = { enabled = true },

      -- Better buffer deletion (preserves window layout)
      bufdelete = { enabled = true },

      -- Open file/line in GitHub/GitLab
      gitbrowse = { enabled = true },

      -- Indent guides
      indent = { enabled = true },

      -- Better vim.ui.input (used by runner.lua prompts)
      input = { enabled = true },

      -- Lazygit integration (explicit float so terminal.win bottom doesn't bleed in)
      lazygit = {
        enabled = true,
        win = {
          style = "lazygit",
          position = "float",
          width = 0.9,
          height = 0.9,
          border = "rounded",
        },
      },

      -- Disabled: noice.nvim owns vim.notify and messages UI
      notifier = { enabled = false },

      -- Picker (used by sidekick.nvim)
      picker = { enabled = true },

      -- Fast file loading
      quickfile = { enabled = true },

      -- Highlight all instances of word under cursor
      words = { enabled = true },

      -- Toggles for common options
      toggle = { enabled = true },

      -- Disabled: we have oil.nvim, mini.statusline, runner.lua
      dashboard  = { enabled = false },
      explorer   = { enabled = false },
      scroll     = { enabled = false },
      zen        = { enabled = true },
      -- Interactive shell (persistent, togglable)
      -- runner.lua uses Snacks.terminal.open() for task running (Dispatch/Npm/Composer)
      terminal = {
        enabled = true,
        win = {
          position = "bottom",
          height = 0.35,
        },
      },
      statuscolumn = { enabled = false },
    },
    keys = {
      -- Lazygit
      { "<leader>gg", function() Snacks.lazygit() end,           desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end,       desc = "Git log (lazygit)" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end,  desc = "Git file history" },
      { "<leader>gB", function() Snacks.gitbrowse() end,         desc = "Git browse (open URL)" },

      -- Buffer delete
      { "<leader>bd", function() Snacks.bufdelete() end,         desc = "Delete buffer" },
      { "<leader>bD", function() Snacks.bufdelete.all() end,     desc = "Delete all buffers" },

      -- Notifications
      { "<leader>un", function() Snacks.notifier.show_history() end, desc = "Notification history" },
      { "<leader>ud", function() Snacks.notifier.hide() end,         desc = "Dismiss notifications" },

      -- Toggles
      { "<leader>us", function() Snacks.toggle.spell() end,            desc = "Toggle spell" },
      { "<leader>uw", function() Snacks.toggle.wrap() end,             desc = "Toggle wrap" },
      { "<leader>ui", function() Snacks.toggle.indent() end,           desc = "Toggle indent guides" },
      { "<leader>uh", function() Snacks.toggle.inlay_hints() end,      desc = "Toggle inlay hints" },
      { "<leader>uD", function() Snacks.toggle.diagnostics() end,      desc = "Toggle diagnostics" },
      { "<leader>uL", function() Snacks.toggle.line_number() end,      desc = "Toggle line numbers" },
      { "<leader>uc", function() Snacks.toggle.option("conceallevel", { off = 0, on = 2 }) end, desc = "Toggle conceal" },
      { "<leader>ub", function()
          vim.o.background = vim.o.background == "dark" and "light" or "dark"
        end, desc = "Toggle background light/dark" },
      { "<leader>uz", function() Snacks.zen() end,        desc = "Toggle zen mode" },
      { "<leader>uZ", function() Snacks.zen.zoom() end,   desc = "Toggle zoom" },

      -- Terminal (interactive shell, separate from runner.lua task terminals)
      { "<C-\\>",     function() Snacks.terminal.toggle() end, mode = { "n", "t" }, desc = "Toggle terminal" },
      { "<leader>rt", function() Snacks.terminal.toggle() end,                      desc = "Toggle terminal" },
      { "<leader>tt", function() Snacks.terminal.toggle() end,                      desc = "Toggle terminal" },
      { "<leader>tf", function() Snacks.terminal() end,                             desc = "Terminal (float)" },

      -- Word reference navigation
      { "]]", function() Snacks.words.jump(vim.v.count1, true) end,  desc = "Next word reference" },
      { "[[", function() Snacks.words.jump(-vim.v.count1, true) end, desc = "Prev word reference" },
    },
  },
}
