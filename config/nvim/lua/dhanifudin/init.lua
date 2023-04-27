require("dhanifudin.config")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local installed, lazy = pcall(require, "lazy")
if installed then
  if vim.g.vscode == nil then
    lazy.setup("dhanifudin.plugins")
  else
    lazy.setup("dhanifudin.vscode")

    vim.keymap.set({ "n", "o", "x" }, "gc", "<Plug>VSCodeCommentary")
    vim.keymap.set("n", "gcc", "<Plug>VSCodeCommentaryLine")
  end
end