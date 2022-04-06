" Reference: `:help dein-examples`

" Prelude {{{1
let s:base_path = (empty($XDG_DATA_HOME) ? expand('~/.local/share') : $XDG_DATA_HOME) . '/dein'
let g:dein#cache_directory = (empty($XDG_CACHE_HOME)
  \ ? expand('~/.cache')
  \ : $XDG_CACHE_HOME) . '/dein'

let s:dein_path = s:base_path . '/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath+=' . s:dein_path

let s:srcdir = expand('<sfile>:h') . '/dein'

call dein#begin(s:base_path)

" List of plugins {{{1
" Be sure to execute the following command after editing this:
" if dein#check_install() | call dein#install() | else | call dein#recache_runtimepath() | endif

" Language support:
call dein#add('euclidianAce/BetterLua.vim')
" Despite the plugin's name, Lua Reference Manual is useful outside Neovim too.
call dein#add('milisims/nvim-luaref')
call dein#add('rust-lang/rust.vim', {'lazy': 1, 'on_ft': 'rust'})
call dein#add('vmchale/dhall-vim')

call dein#add('chrisbra/Recover.vim')
call dein#add('editorconfig/editorconfig-vim', {
  \'hook_post_source': 'source ' . s:srcdir . '/editorconfig.vim',
  \})
call dein#add('rhysd/conflict-marker.vim')
call dein#add('Shougo/dein.vim')
call dein#add('tesaguri/trust.vim', {'hook_post_source': 'source ' . s:srcdir . '/trust.vim'})

" Vim plugin development:
" `:Vitalize` requires its runtimepath to be a git repository rather than a merged one.
call dein#add('vim-jp/vital.vim', {
  \'lazy': 1,
  \'on_cmd': 'Vitalize',
  \'on_ft': 'vim',
  \})
call dein#add('lambdalisue/vital-Whisky')

" Don't be too afraid of adding Neovim-specific plugins.
" I only use Vim in limited situations like through SSH and don't demand fancy things from it.
if has('nvim')
  " LSP clients:
  call dein#add('neovim/nvim-lspconfig', {'lazy': 1, 'on_ft': ['dhall', 'lua', 'rust']})
  call dein#add('simrat39/rust-tools.nvim', {
    \'depends': 'nvim-lspconfig',
    \'hook_post_source': 'luafile ' . s:srcdir . '/rust-tools.lua',
    \'lazy': 1,
    \'on_ft': 'rust',
    \})

  " Unlike `nvim-luaref`, this is specific to Neovim and does not make much sense outside it.
  call dein#add('nanotee/nvim-lua-guide')

  " Completion:
  call dein#add('hrsh7th/cmp-buffer')
  call dein#add('hrsh7th/cmp-nvim-lsp', {'lazy': 1, 'on_source': 'nvim-lspconfig'})
  call dein#add('hrsh7th/cmp-vsnip')
  call dein#add('hrsh7th/nvim-cmp', {'hook_post_source': 'luafile ' . s:srcdir . '/cmp.lua'})
  call dein#add('hrsh7th/vim-vsnip')
endif

" Postlude {{{1
call dein#end()

" See `:help dein-options-hook_post_source`.
autocmd vimrc VimEnter * call dein#call_hook('post_source')

if !has('nvim')
  filetype plugin indent on
  syntax enable
endif

" vim: fdm=marker
