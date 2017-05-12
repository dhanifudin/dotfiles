" vim: set foldmethod=marker:

function! CompletionTab()
  if neosnippet#expandable_or_jumpable()
    return "\<Plug>(neosnippet_expand_or_jump)"
  elseif pumvisible()
    return "\<C-n>"
  elseif getline('.')[col('.') - 1] =~# '["\]'')}]'
    return "\<Right>"
  else
    return "\<TAB>"
  endif
endfunction

" auto-pairs {{{
" let g:AutoPairsMapCR = 0
" }}}

if has('nvim')

  " deoplete {{{
  if exists('g:plugs["deoplete.nvim"]')
    " let g:deoplete#auto_complete_start_length = 0
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#enable_camel_case = 1
    let g:deoplete#enable_smart_case = 1
    " let g:deoplete#sources = {}
    " let g:deoplete#sources._ = ['buffer', 'neosnippet']
    " let g:deoplete#sources.typescript = ['buffer', 'tsuquyomi', 'neosnippet']
    let g:deoplete#omni#input_patterns = {}
    let g:deoplete#omni#input_patterns.typescript = ['[^. \t0-9]\.\w*']
    " let g:tsuquyomi_completion_detail = 1

    imap <silent><expr><TAB> CompletionTab()

    smap <silent><expr><TAB> neosnippet#expandable_or_jumpable() ?
          \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    imap <silent><expr><S-TAB> pumvisible() ?
          \ "\<C-p>" : "\<S-TAB>"

    " imap <C-R>=.<CR> pumvisible() ?
    "       \ deoplete#mappings#close_popup() : "\<CR>\<Plug>AutoPairsReturn"

    " imap <CR> <C-R>=pumvisible() ? deoplete#mappings#close_popup() : "\n"<CR>
  endif
  " }}}

  " deoplete-padawan {{{
  if exists('g:plugs["deoplete-padawan"]')
    let g:deoplete#sources#padawan#add_parentheses = 1
    command! StartPadawan call deoplete#sources#padawan#StartServer()
    command! StopPadawan call deoplete#sources#padawan#StopServer()
    command! RestartPadawan call deoplete#sources#padawan#RestartServer()
  endif
  " }}}

endif
