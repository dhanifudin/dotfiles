require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = { require("formatter.filetypes.lua").stylua },
		go = { require("formatter.filetypes.go").gofmt },
		haskell = { require("formatter.filetypes.haskell").stylish_haskell },
		javascript = { require("formatter.filetypes.javascript").standard },
		javascriptreact = { require("formatter.filetypes.javascriptreact").standard },
		latex = { require("formatter.filetypes.latex").latexindent },
		python = { require("formatter.filetypes.python").black },
		yaml = { require("formatter.filetypes.yaml").yamlfmt },
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

vim.cmd([[autocmd BufWritePost * FormatWrite]])
