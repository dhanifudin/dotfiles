return {
  {
    "ahmedkhalf/project.nvim",
    opts = {
      detection_methods = { "pattern", "lsp" },
      patterns = {
        ".git",
        "package.json",
        "composer.json",
        "go.mod",
        "Cargo.toml",
        "pyproject.toml",
        "setup.py",
        "Makefile",
        ".terraform",
        "docker-compose.yml",
        "docker-compose.yaml",
      },
      silent_chdir = true,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find Projects" },
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.stdpath("state") .. "/sessions/",
      options = { "buffers", "curdir", "tabpages", "winsize" },
    },
    keys = {
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore Session",
      },
      {
        "<leader>qS",
        function()
          require("persistence").select()
        end,
        desc = "Select Session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore Last Session",
      },
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Don't Save Current Session",
      },
    },
  },
}
