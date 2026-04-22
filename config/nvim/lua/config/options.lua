local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Sign column + cursor
opt.signcolumn = "yes"
opt.cursorline = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- Wrapping
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Files
opt.undofile = true
opt.swapfile = false
opt.backup = false

-- Scroll
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Terminal colors
opt.termguicolors = true

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Mouse
opt.mouse = "a"

-- UI
opt.showmode = false
opt.fillchars = { eob = " " }
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
