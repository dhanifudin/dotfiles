local set = vim.opt
local cmd = vim.cmd

set.mouse = "a"

set.background = "dark"
set.cursorline = true

set.autoindent = true
set.smartindent = true
set.clipboard = "unnamed"
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true

set.hidden = true

set.swapfile = false
set.ignorecase = true
set.smartcase = true
set.incsearch = true

cmd [[
  set path+=**
  colorscheme gruvbox
]]
