" Interface
set clipboard+=unnamedplus
let &mouse = 'a'

" Appearance
set colorcolumn+=101
if exists('+cursorlineopt')
  let &cursorline = 1
  let &cursorlineopt = 'number'
endif
let &number = 1
let &termguicolors = 1
if exists('+winblend')
  let &winblend = 30
endif

if !has('nvim')
  " See `:help xterm-true-color` in Vim.
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
