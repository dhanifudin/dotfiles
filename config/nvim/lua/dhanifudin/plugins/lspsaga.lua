local status, saga = pcall(require, "lspsaga")

if status then
	saga.init_lsp_saga()

	vim.api.nvim_set_keymap("n", "<leader>ca", ":Lspsaga code_action<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("v", "<leader>ca", ":<C-U>Lspsaga range_code_action<CR>", { noremap = true, silent = true })
end
