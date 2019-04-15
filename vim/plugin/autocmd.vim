" vim: set foldmethod=marker:

if has('autocmd')

  augroup config
    autocmd!
    " Automatically leave paste mode
    autocmd InsertLeave * set nopaste

    " Remember last cursor position
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

  augroup END

  augroup mapping
    autocmd! CmdwinEnter * nnoremap <buffer> q <c-c><c-c>
  augroup END

  augroup ng
    autocmd!
    autocmd VimEnter *
      \ if globpath('.,..','node_modules/@angular') != '' |
      \ call angular_cli#init() |
      \ endif
  augroup END

endif
