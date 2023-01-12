return {
	"svermeulen/vim-yoink",
	config = function()
		vim.g.yoinkIncludeDeleteOperations = 1
		vim.g.yoinkSavePersistently = 1
		vim.g.yoinkAutoFormatPaste = 1

		vim.keymap.set({ "n", "x" }, "m", "d")
		vim.keymap.set("n", "mm", "dd")
		vim.keymap.set("n", "M", "D")

		vim.keymap.set("n", "p", "<plug>(YoinkPaste_p)")
		vim.keymap.set("n", "P", "<plug>(YoinkPaste_P)")
	end,
}
