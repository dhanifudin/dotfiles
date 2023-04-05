local status, formatter = pcall(require, "formatter")

if status then
	formatter.setup({
		logging = true,
		log_level = vim.log.levels.WARN,
		filetype = {
			go = { require("formatter.filetypes.go").gofmt },
			haskell = { require("formatter.filetypes.haskell").stylish_haskell },
			javascript = { require("formatter.filetypes.javascript").standard },
			javascriptreact = { require("formatter.filetypes.javascriptreact").standard },
			latex = { require("formatter.filetypes.latex").latexindent },
			lua = { require("formatter.filetypes.lua").stylua },
			python = { require("formatter.filetypes.python").black },
			yaml = { require("formatter.filetypes.yaml").yamlfmt },
      c = { require("formatter.filetypes.c").clangformat },
      cpp = { require("formatter.filetypes.cpp").clangformat },
			["*"] = {
				require("formatter.filetypes.any").remove_trailing_whitespace,
			},
		},
	})

	vim.cmd([[
    augroup formatter_autocmd
      autocmd!
      autocmd BufWritePost * FormatWrite
    augroup end
  ]])
end