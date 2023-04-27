return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    local installed, gruvbox = pcall(require, "gruvbox")
    if installed then
      gruvbox.setup()
      vim.cmd("colorscheme gruvbox")
    else
      vim.cmd("colorscheme habamax")
      print("Colorscheme not found!")
    end
  end,
}