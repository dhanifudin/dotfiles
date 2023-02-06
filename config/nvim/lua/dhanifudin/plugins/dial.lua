return {
	"monaqa/dial.nvim",
	keys = { "<C-a>", "<C-x>" },
	config = function()
		local status, dial = pcall(require, "dial.map")
		if status then
			local keymap = vim.keymap
			keymap.set("n", "<C-a>", dial.inc_normal(), { noremap = true })
			keymap.set("n", "<C-x>", dial.dec_normal(), { noremap = true })
			keymap.set("v", "<C-a>", dial.inc_visual(), { noremap = true })
			keymap.set("v", "<C-x>", dial.dec_visual(), { noremap = true })
			keymap.set("v", "g<C-a>", dial.inc_gvisual(), { noremap = true })
			keymap.set("v", "g<C-x>", dial.dec_gvisual(), { noremap = true })
		end
	end,
}
