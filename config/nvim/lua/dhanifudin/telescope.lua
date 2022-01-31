vim.api.nvim_set_keymap("n", "gof", ":Telescope find_files<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gog", ":Telescope live_grep<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "goG", ":Telescope git_stash<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "goc", ":Telescope command_history<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gob", ":Telescope buffers<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "got", ":Telescope treesitter<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "goT", ":Telescope tags<cr>", { noremap = true, silent = true })