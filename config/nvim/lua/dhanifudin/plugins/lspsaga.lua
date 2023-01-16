return {
	"glepnir/lspsaga.nvim",
	event = "BufRead",
	config = function()
		local status, saga = pcall(require, "lspsaga")
		if status then
			local keymap = vim.keymap.set
			saga.setup({})
			keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
			keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { noremap = true, silent = true })
			keymap("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { noremap = true, silent = true })

			-- Diagnsotic jump can use `<c-o>` to jump back
			keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
			keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

			-- Diagnostic jump with filter like Only jump to error
			keymap("n", "[E", function()
				require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end)
			keymap("n", "]E", function()
				require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
			end)
		end
	end,
}
