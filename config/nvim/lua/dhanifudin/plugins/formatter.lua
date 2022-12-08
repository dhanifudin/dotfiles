-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		lua = { require("formatter.filetypes.lua").stylua },
		go = { require("formatter.filetypes.go").gofmt },
		haskell = { require("formatter.filetypes.haskell").stylish_haskell },
		python = { require("formatter.filetypes.python").black },
		yaml = { require("formatter.filetypes.yaml").yamlfmt },
		["*"] = {
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})

vim.cmd [[autocmd BufWritePost * FormatWrite]]
