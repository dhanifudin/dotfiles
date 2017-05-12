" ctrlp {{{
let g:ctrlp_map = '<leader>f'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_open_new_file = 'r'

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>h :CtrlPCmdHistory<CR>
nnoremap <leader>s :CtrlPFunky<CR>
nnoremap <leader>c :CtrlPCmdPalette<CR>
" }}}

" netrw {{{
let g:netrw_banner = 0
let g:netrw_home = $HOME.'/.cache/vim'
let g:netrw_keepdir = 1
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_liststyle = 3
let g:netrw_winsize = 20
" netrw }}}

" easymotion {{{
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_do_shade = 1
let g:EasyMotion_smartcase = 1

nmap s <Plug>(easymotion-s)
omap s <Plug>(easymotion-s)
xmap s <Plug>(easymotion-s)

highlight link EasyMotionTarget Search
highlight link EasyMotionShade Comment
" }}}

if exists('g:plugs["tagbar"]')
  let g:tagbar_compact = 1
  let g:tagbar_width = 24
endif

" if exists('g:plugs["vim-unimpaired"]')
"   nmap < [
"   nmap > ]
"   omap < [
"   omap > ]
"   xmap < [
"   xmap > ]
" endif

" multiple-cursors {{{
let g:multi_cursor_use_default_mapping = 0

let g:multi_cursor_start_key = '<Tab>'
let g:multi_cursor_next_key = '<C-n>'
let g:multi_cursor_prev_key = '<C-p>'
let g:multi_cursor_skip_key = '<C-x>'
let g:multi_cursor_quit_key = '<Esc>'
" }}}
