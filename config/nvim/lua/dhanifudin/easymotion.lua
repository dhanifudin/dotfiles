vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_smartcase = 1

vim.api.nvim_set_keymap("n", "s", "<Plug>(easymotion-overwin-f)", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "/", "<Plug>(easymotion-sn)", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "/", "<Plug>(easymotion-tn)", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "gj", "<Plug>(easymotion-j)", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "gk", "<Plug>(easymotion-k)", { noremap = false, silent = true })
