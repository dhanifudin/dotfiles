vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local status, nvimtree = pcall(require, "nvim-tree")

if status then
	nvimtree.setup({
		sort_by = "case_sensitive",
		view = {
			adaptive_size = true,
		},
		filters = {
			dotfiles = true,
		},
	})
end
