let g:mapleader = "\<Space>"

noremap j gj
noremap k gk

nnoremap gb :bnext<CR>
nnoremap gB :bprevious<CR>

nnoremap ! :!

xnoremap H <gv
xnoremap J :m '>+1<Enter>gv=gv
xnoremap K :m '<-2<Enter>gv=gv
xnoremap L >gv

" search {{{
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
" }}}


" navigation command mode {{{
cnoremap <C-h> <left>
cnoremap <C-j> <down>
cnoremap <C-k> <up>
cnoremap <C-l> <right>
" }}}

if exists('g:plugs["emmet-vim"]')
  let g:user_emmet_leader_key=','
endif
