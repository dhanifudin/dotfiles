vim.g.mapleader = " "

local keymap = vim.keymap.set

keymap("n", "j", "gj")
keymap("n", "k", "gk")

keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

keymap("n", ";", ":", { noremap = true, silent = true })
keymap("n", "q;", "q:", { noremap = true, silent = true })
keymap("n", "!", ":!", { noremap = true, silent = true })
keymap("x", ";", ":", { noremap = true, silent = true })

keymap("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move down" })
keymap("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move up" })