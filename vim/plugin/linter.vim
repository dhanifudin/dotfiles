scriptencoding utf-8

if exists('g:plugs["ale"]')
  let g:ale_sign_error = '⨉'
  let g:ale_sign_warning = '⚠ '
  let g:ale_statusline_format = ['⨉ %d', '⚠  %d', '✓']

  let g:ale_php_phpcs_standard = 'PSR2'

  let g:ale_linters = {
        \ 'html': ['htmlhint'],
        \ 'javascript': ['eslint'],
        \ 'jsx': ['stylelint', 'eslint'],
        \ }
endif
