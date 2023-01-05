vim.g.mapleader = " "

local keymap = vim.keymap.set

keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

keymap("n", "j", "gj")
keymap("n", "k", "gk")

keymap("n", "J", "mzJ`z")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

keymap("n", ";", ":", { noremap = true, silent = true })
keymap("n", "q;", "q:", { noremap = true, silent = true })
keymap("n", "!", ":!", { noremap = true, silent = true })
keymap("x", ";", ":", { noremap = true, silent = true })
