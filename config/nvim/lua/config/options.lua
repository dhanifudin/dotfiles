-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local set = vim.opt

set.swapfile = false
vim.g.lazyvim_picker = "fzf"
vim.g.lazyvim_python_lsp = "basedpyright"
