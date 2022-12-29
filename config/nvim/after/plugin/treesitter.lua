local status, treesitter = pcall(require, "nvim-treesitter.configs")

if status then
	local vim = vim
	local opt = vim.opt

	opt.foldmethod = "expr"
	opt.foldexpr = "nvim_treesitter#foldexpr()"

	treesitter.setup({
		ensure_installed = "all",
		highlight = {
			enable = true,
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.outer",
					["ac"] = "@function.outer",
					["ic"] = "@function.outer",
				},
			},
		},
	})
end
