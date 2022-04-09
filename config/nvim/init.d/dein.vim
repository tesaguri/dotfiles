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
" Language support:
call dein#add('euclidianAce/BetterLua.vim')
" Despite the plugin's name, Lua Reference Manual is useful outside Neovim too.
call dein#add('milisims/nvim-luaref')
call dein#add('rust-lang/rust.vim', {'lazy': 1, 'on_ft': 'rust'})
call dein#add('vmchale/dhall-vim')

" Lilypond bundles a Vim plugin with it.
for s:rtp in glob('/usr/local/share/lilypond/*/vim', 1, 1)
  call dein#add(s:rtp, {'merged': 1})
  " Sourcing one version should be enough.
  " (dein would overwrite the runtime files while merging the runtimepath otherwise)
  break
endfor

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
  " Language support:
  " `nvim-treesitter` installs parsers to its runtimepath.
  " If it were merged, the parsers would be overwritten by `dein#recache_runtimepath()`.
  call dein#add('nvim-treesitter/nvim-treesitter', {
    \'hook_post_source': 'luafile ' . s:srcdir . '/nvim-treesitter.lua',
    \'lazy': 1,
    \'on_ft': ['html', 'javascript', 'json', 'sh'],
    \})

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

" Regenerate the runtimepath after this file is modified (and possibly plugin configs are changed).
execute 'autocmd vimrc BufWritePost ' . resolve(expand('<sfile>')) . ' ++once'
  \ . ' source ' . expand('<sfile>')
  \ . ' | if dein#check_install()'
  \ . ' | call dein#install()'
  \ . ' | else'
  \ . ' | call dein#recache_runtimepath()'
  \ . ' | endif'

if has('vim_starting')
  " See `:help dein-options-hook_post_source`.
  autocmd vimrc VimEnter * call dein#call_hook('post_source')
endif

if !has('nvim')
  filetype plugin indent on
  syntax enable
endif

" vim: fdm=marker
