vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", ";", ":", { noremap = true, silent = true })
keymap.set("n", "q;", "q:", { noremap = true, silent = true })
keymap.set("n", "!", ":!", { noremap = true, silent = true })
keymap.set("x", ";", ":", { noremap = true, silent = true })
--
-- vim.api.nvim_set_keymap("n", ";", ":", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "q;", "q:", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "!", ":!", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("x", ";", ":", { noremap = true, silent = true })
