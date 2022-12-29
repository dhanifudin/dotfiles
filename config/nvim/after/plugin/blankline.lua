local status, blankline = pcall(require, "indent_blankline")

if status then
	vim.opt.list = true
	vim.opt.listchars:append("space:⋅")
	vim.opt.listchars:append("eol:↴")
	blankline.setup({
		space_char_blankline = " ",
		show_current_context = true,
		show_current_context_start = true,
	})
end
