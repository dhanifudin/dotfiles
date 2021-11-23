" vim: set foldmethod=marker:

" ack {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif
" }}}
