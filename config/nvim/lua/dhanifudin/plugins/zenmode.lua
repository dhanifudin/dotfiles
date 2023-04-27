return {
  "folke/zen-mode.nvim",
  config = function()
    local status, zenmode = pcall(require, "zen-mode")

    if status then
      zenmode.setup({
        {
          window = {
            backdrop = 0.8,
            options = {
              signcolumn = "no",
              number = false,
              relativenumber = false,
              cursorline = true,
              foldcolumn = "0",
              list = false,
            },
          },
          plugins = {
            tmux = { enabled = true },
            kitty = {
              enabled = true,
              font = "+2",
            },
          },
        },
      })
    end
  end,
}