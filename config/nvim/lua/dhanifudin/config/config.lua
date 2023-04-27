local set = vim.opt
local fn = vim.fn

set.mouse = "a"

set.relativenumber = true
set.number = true

set.autoindent = true
set.smartindent = true
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
set.wrap = false

set.hidden = true

set.swapfile = false
set.ignorecase = true
set.smartcase = true
set.incsearch = true

if fn.has("persistent_undo") then
	set.undofile = true
end

set.termguicolors = true
set.background = "dark"
set.signcolumn = "yes"
set.cursorline = true

set.backspace = "indent,eol,start"

set.scrolloff = 8

-- clipboard
set.clipboard:append("unnamedplus")

set.splitright = true
set.splitbelow = true
