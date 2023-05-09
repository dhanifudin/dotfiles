return {
  "folke/noice.nvim",
  config = function()
    local installed, noice = pcall(require, "noice")
    if installed then
      noice.setup()
    end
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
  }
}