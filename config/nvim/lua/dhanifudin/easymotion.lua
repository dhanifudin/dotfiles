if vim.api.nvim_eval('exists("g:vscode")') == 1 then
  vim.g.EasyMotion_do_mapping = 1
else
  vim.g.EasyMotion_do_mapping = 0
end

vim.g.EasyMotion_smartcase = 1


-- if not is_vscode then
  -- vim.api.vim_set_keymap("n", "s", "<Plug>(easymotion-overwin-f)", { noremap = false, silent = true })
-- end

vim.api.nvim_set_keymap("n", "/", "<Plug>(easymotion-sn)", { noremap = false, silent = true })
vim.api.nvim_set_keymap("o", "/", "<Plug>(easymotion-tn)", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "gj", "<Plug>(easymotion-j)", { noremap = false, silent = true })
vim.api.nvim_set_keymap("n", "gk", "<Plug>(easymotion-k)", { noremap = false, silent = true })
