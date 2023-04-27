return {
	"asvetliakov/vim-easymotion",
	config = function()
		vim.g.EasyMotion_do_mapping = 0
		vim.g.EasyMotion_smartcase = 1
		vim.keymap.set({ "n", "o", "x" }, "s", "<Plug>(easymotion-s)")
	end,
}
