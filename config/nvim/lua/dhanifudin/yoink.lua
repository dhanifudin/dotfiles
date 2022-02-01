vim.g.yoinkIncludeDeleteOperations = 1

vim.api.nvim_set_keymap("n", "[y", "<plug>(YoinkRotateBack)", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "]y", "<plug>(YoinkRotateForward)", { noremap = false, silent = true })
