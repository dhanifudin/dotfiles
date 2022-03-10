if empty(glob('~/.config/nvim/autoload/plug.vim'))
  echo 'Installing vim-plug...'
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo 'Run :PlugInstall to install plugins'
endif

call plug#begin('~/.config/nvim/plugged')
" tpope
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" textobject
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'Julian/vim-textobj-variable-segment'

" navigation
Plug 'asvetliakov/vim-easymotion'

" misc
Plug 'mbbill/undotree'
Plug 'svermeulen/vim-easyclip'
call plug#end()

" Comment
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" Easymotion plugin
let g:EasyMotion_keys = 'qwerasdfzxcv'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_do_shade = 1
let g:EasyMotion_smartcase = 1

nmap s <Plug>(easymotion-s)
omap s <Plug>(easymotion-s)
xmap s <Plug>(easymotion-s)

highlight link EasyMotionTarget Search
highlight link EasyMotionShade Comment
