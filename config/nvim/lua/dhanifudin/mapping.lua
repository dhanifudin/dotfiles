vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", ";", ":", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "q;", "q:", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "!", ":!", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", ";", ":", { noremap = true, silent = true })
