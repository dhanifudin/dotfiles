local status, saga = pcall(require, "lspsaga")

if status then
	local keymap = vim.keymap.set

	saga.init_lsp_saga()

	keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
	keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { noremap = true, silent = true })
	keymap("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { noremap = true, silent = true })
end
