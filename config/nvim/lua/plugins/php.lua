return {
  recommended = {
    ft = "php",
    root = { "composer.json", ".phpactor.json", ".phpactor.yml" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "php" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        phpactor = {
          enabled = "phpactor",
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "pint",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      local path = require("mason-registry").get_package("php-debug-adapter"):get_install_path()
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { path .. "/extension/out/phpDebug.js" },
      }
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function()
      local lint = require("lint")
      lint.linters.pint = {
        name = "pint",
        cmd = "pint",
      }
      lint.linters_by_ft = {
        php = { "pint" },
      }
    end,
  },
}
