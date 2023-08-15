return {
  { "ellisonleao/gruvbox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
        dhanifudin.vim
        Powered by LazyVim
      ]]
      dashboard.section.header.val = vim.split(logo, "\n")
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      top_down = false,
    },
  },
}