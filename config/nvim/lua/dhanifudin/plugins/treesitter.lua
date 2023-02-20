return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local status, treesitter = pcall(require, "nvim-treesitter.configs")

		if status then
			local vim = vim
			local opt = vim.opt

			opt.foldmethod = "expr"
			opt.foldexpr = "nvim_treesitter#foldexpr()"
			opt.foldenable = false

			treesitter.setup({
				ensure_installed = {
					"bash",
					"c",
					"cpp",
					"dockerfile",
					"go",
					"gomod",
					"fortran",
					"haskell",
					"html",
					"javascript",
					"jsdoc",
					"json",
					"json5",
					"jsonc",
					"lua",
					"php",
					"python",
					"yaml",
				},
				auto_install = true,
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
	end,
}
