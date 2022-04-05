" Interface {{{1
set clipboard+=unnamedplus
let &mouse = 'a'

" Appearance {{{1
set colorcolumn+=101
let &number = 1
let &relativenumber = 1
let &termguicolors = 1
if exists('+winblend')
  let &winblend = 30
endif

if !has('nvim')
  " See `:help xterm-true-color` in Vim.
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Indent {{{1
let &copyindent = 1
let &expandtab = 1
let &shiftwidth = 4
let &smartindent = 1
let &softtabstop = -1

" }}}
" vim: fdm=marker
