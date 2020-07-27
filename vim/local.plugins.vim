" colorschemes
Plug 'morhetz/gruvbox'

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" if executable('pyenv')
"   let g:python_host_prog = $HOME . '/.pyenv/versions/neovim2/bin/python'
"   let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'
" endif

" filetypes
Plug 'chrisbra/csv.vim'
Plug 'sheerun/vim-polyglot'

Plug 'roman/golden-ratio'
Plug 'shime/vim-livedown'
Plug 'sunaku/vim-dasht'
Plug 'vim-scripts/cmdline-completion'

" general
Plug 'mileszs/ack.vim'
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'mbbill/undotree'
Plug 'mattn/webapi-vim'
Plug 'KabbAmine/gulp-vim'
Plug 'EinfachToll/DidYouMean'
Plug 'jiangmiao/auto-pairs'

" tpope
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'

" textobject
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-entire'
Plug 'Julian/vim-textobj-variable-segment'
Plug 'thinca/vim-textobj-function-javascript'

" eyecandy
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'

" junegunn
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-slash'

" ctrlp
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fisadev/vim-ctrlp-cmdpalette'
Plug 'ompugao/ctrlp-history'
Plug 'tacahiroy/ctrlp-funky'

Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'svermeulen/vim-easyclip'
Plug 'Yggdroot/indentLine'
Plug 'docunext/closetag.vim'
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'

if executable('python')
  Plug 'davidhalter/jedi-vim'
endif

if executable('go')
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
endif

" node
if executable('node')
  Plug 'bdauria/angular-cli.vim'
endif

" php
if executable('php')
  Plug 'noahfrederick/vim-composer'
  Plug 'noahfrederick/vim-laravel'
endif

" notes
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'

Plug 'wakatime/vim-wakatime'
