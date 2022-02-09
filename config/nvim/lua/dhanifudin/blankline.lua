vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guifg=red gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guifg=yellow gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent3 guifg=green gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent4 guifg=blue gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent5 guifg=cyan gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent6 guifg=magenta gui=nocombine]]

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}
