vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-c>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
