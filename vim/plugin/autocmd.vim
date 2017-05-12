" vim: set foldmethod=marker:

function! s:neosnippetEvent()
  NeoSnippetClearMarkers
  if pumvisible() == 0
    pclose
  endif
endfunction

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

  augroup goyo
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!
  augroup END

  " augroup autoformat
  "   if exists('g:plugs["vim-autoformat"]')
  "     autocmd! BufWritePre * :Autoformat
  "   endif
  " augroup END

  augroup snippet
    autocmd InsertLeave * call s:neosnippetEvent()
  augroup END

  augroup java
    autocmd!
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
  augroup END

  augroup ng
    autocmd!
    autocmd VimEnter *
          \ if globpath('.,..','node_modules/@angular') != '' |
          \ call angular_cli#init() |
          \ endif
  augroup END

endif
