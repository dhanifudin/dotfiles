vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")

keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("n", ";", ":", { noremap = true, silent = true })
keymap.set("n", "q;", "q:", { noremap = true, silent = true })
keymap.set("n", "!", ":!", { noremap = true, silent = true })
keymap.set("x", ";", ":", { noremap = true, silent = true })
