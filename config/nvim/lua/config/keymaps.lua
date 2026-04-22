local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true })
end

-- Faster command mode (no shift needed) — silent=false so cmdline shows
vim.keymap.set("n", ";", ":", { desc = "Command mode" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", "Prev buffer")
map("n", "<S-l>", "<cmd>bnext<cr>", "Next buffer")
map("n", "[b", "<cmd>bprevious<cr>", "Prev buffer")
map("n", "]b", "<cmd>bnext<cr>", "Next buffer")
-- <leader>bd handled by snacks.bufdelete (preserves window layout)

-- Better visual indent (keep selection)
map("v", "<", "<gv", "Indent left")
map("v", ">", ">gv", "Indent right")

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", "Move line down")
map("n", "<A-k>", "<cmd>m .-2<cr>==", "Move line up")
map("v", "<A-j>", ":m '>+1<cr>gv=gv", "Move selection down")
map("v", "<A-k>", ":m '<-2<cr>gv=gv", "Move selection up")

-- Diagnostics
map("n", "[d", function() vim.diagnostic.goto_prev() end, "Prev diagnostic")
map("n", "]d", function() vim.diagnostic.goto_next() end, "Next diagnostic")
map("n", "<leader>cd", function() vim.diagnostic.open_float() end, "Diagnostic float")

-- Quit
map("n", "<leader>qq", "<cmd>qa<cr>", "Quit all")
