return {
  {
    "nvimdev/dashboard-nvim",
    opts = {
      theme = "hyper",
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          {
            desc = " Find File",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          {
            desc = " Grep Text",
            group = "Label",
            action = "Telescope live_grep",
            key = "g",
          },
          {
            desc = " Projects",
            group = "Label",
            action = "Telescope projects",
            key = "p",
          },
          {
            desc = " Restore Session",
            group = "Label",
            action = function()
              require("persistence").load()
            end,
            key = "s",
          },
          {
            desc = " Config",
            group = "Label",
            action = "Telescope find_files cwd=" .. vim.fn.stdpath("config"),
            key = "c",
          },
          {
            desc = " Lazy",
            group = "Label",
            action = "Lazy",
            key = "l",
          },
          {
            desc = " Quit",
            group = "Label",
            action = "qa",
            key = "q",
          },
        },
        project = {
          enable = true,
          limit = 8,
          icon = " ",
          action = function(path)
            require("telescope.builtin").find_files({ cwd = path })
          end,
        },
        mru = {
          enable = true,
          limit = 10,
          cwd_only = false,
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
          return { "⚡ " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    },
  },
}
