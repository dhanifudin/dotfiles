if strftime('%H') > 6 + 0
      \ && strftime('%H') < 18 + 0
  set background=dark
else
  set background=light
endif

try
  colorscheme gruvbox
catch
  colorscheme desert
endtry

" {{{ airline
let g:airline_exclude_preview = 1
let g:airline_detect_paste = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'
let g:airline_section_warning = '%{ALEGetStatusLine()}'

" Airline Extensions
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'z', 'warning' ]
      \ ]

let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V-LINE',
      \ '' : 'V-BLOCK',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }
" airline }}}

highlight ExtraWhitespace ctermbg=red guibg=red

augroup whitespace
  autocmd!
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
augroup END
