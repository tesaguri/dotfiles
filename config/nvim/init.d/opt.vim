" Cherry-pick |nvim-defaults| {{{1
if !has('nvim')
  let &autoindent = 1
  let &autoread = 1
  " Vim does not seem to detect background color of my Alacritty correctly.
  let &background = 'dark'
  let &encoding = 'utf-8'
  if has('extra_search')
    let &hlsearch = 1
  endif
  let &laststatus = 2
  let &smarttab = 1
endif

if has('nvim')
  if exists('#vimStartup')
    echomsg 'opt.vim: Overwriting an existing #vimStartup augroup.'
    \ 'Unless you are re-sourcing `opt.vim` script, Neovim might have defined the augroup for you,'
    \ 'in which case, check the script and consider updating it!'
  endif
  augroup vimStartup
    autocmd!
    " Jump to the cursor position the last session (|last-position-jump|).
    " In Vim, an equivalent of this is defined in |defaults.vim| file, but Neovim doesn't have that.
    autocmd BufRead * autocmd FileType <buffer> ++once
    \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$")
      \ | execute 'normal! g`"'
    \ | endif
  augroup END
endif

" Interface {{{1
set clipboard+=unnamedplus
if ExecutableSuccess('rg --version')
  let &grepprg = 'rg --vimgrep "$@"'
  let &grepformat = '%f:%l:%c:%m'
endif
let &mouse = 'a'
if has('patch-8.2.4325')
  set wildoptions+=pum
endif

" Appearance {{{1
set colorcolumn+=101
let &display = 'lastline'
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

" Editor {{{1
let &copyindent = 1
let &expandtab = 1
let &fileencodings = 'ucs-bom,utf-8,sjis,cp932,euc-jp,default,latin1'
let &shiftwidth = 4
let &smartindent = 1
let &softtabstop = -1

" Default plugins {{{1
" json.vim {{{2
let g:vim_json_conceal = 0

" sh.vim {{{2
" I read |sh.vim| and still don't understand why it defaults to the ancient Bourne shell syntax.
let g:is_posix = 1

" }}}1

" vim: fdm=marker fdl=1
