" vim: set foldmethod=marker:

" ack {{{
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif
" }}}

" {{{ ale
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠ '
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '✓']

let g:ale_linters = {
      \ 'html': ['htmlhint'],
      \ 'javascript': ['eslint'],
      \ }
" }}}

" {{{ goyo
" let g:goyo_width = 81
" let g:goyo_margin_top = 2
" let g:goyo_margin_bottom = 2
" let g:goyo_linenr = 0
" goyo}}}

" {{{ limelight
let g:limelight_conceal_ctermfg = 'Gray'
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_default_coefficient = 0.5
" limelight}}}

" angular-cli {{{
let g:angular_cli_stylesheet_format = 'scss'
let g:angular_cli_use_dispatch = 1
" }}}
"
" let g:golden_ratio_exclude_nonmodifiable = 1
