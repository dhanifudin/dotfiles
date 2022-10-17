if exists('g:vscode')
  source $HOME/.config/nvim/vscode.vim
else
  lua require('dhanifudin')
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
  augroup END
endif
