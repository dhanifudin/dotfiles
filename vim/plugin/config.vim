if !has('nvim')
  set encoding=utf-8
  set nocompatible
else

endif

if has('mouse')
  set mouse=a
endif

set path+=**
set clipboard=unnamed

" cursor
set cursorline

" remove backup
set nowritebackup
set noswapfile
set hidden

" search config
set hlsearch
set ignorecase
set smartcase
set incsearch
