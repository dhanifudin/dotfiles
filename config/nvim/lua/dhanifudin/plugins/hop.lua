local hop = require("hop")

hop.setup({
	case_insensitive = false,
	keys = "etovxqpdygfblzhckisuran",
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
