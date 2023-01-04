local status, hop = pcall(require, "hop")

if status then
	hop.setup({
		case_insensitive = false,
		keys = "qwertyuiopasdfghjkl",
	})

	vim.keymap.set("", "s", function()
		hop.hint_char2({ inclusive_jump = true })
	end, { remap = true })

	vim.keymap.set("", "f", function()
		hop.hint_char1({ current_line_only = true })
	end, { remap = true })

	vim.keymap.set("", "t", function()
		hop.hint_char1({ current_line_only = true, hint_offset = -1 })
	end, { remap = true })

	vim.cmd([[
    highlight HopNextKey guifg=red
    highlight HopNextKey1 guifg=red
    highlight HopNextKey2 guifg=red
  ]])
end
