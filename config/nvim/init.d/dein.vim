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
" Lua syntax that aims at being better than built-in one.
" Specifically, it highlights EmmyLua annotations nicely.
call dein#add('euclidianAce/BetterLua.vim')
" Adds the Lua 5.1 Reference Manual to `:help`.
" Despite the plugin's name, Lua Reference Manual is useful outside Neovim too.
call dein#add('milisims/nvim-luaref')
" Syntax and ftplugin for Rust, the best systems programming language ever.
call dein#add('rust-lang/rust.vim', {'lazy': 1, 'on_ft': 'rust'})
" Syntax for Dhall, a programmable configuration language.
call dein#add('vmchale/dhall-vim')

" LilyPond, the GNU music engraving program, bundles a Vim plugin with it.
for s:rtp in glob('/usr/local/share/lilypond/*/vim', 1, 1)
  call dein#add(s:rtp, {'merged': 1})
  " Sourcing one version should be enough.
  " (dein would overwrite the runtime files while merging the runtimepath otherwise)
  break
endfor

" Editor utilities:
" Shows diff between the swap and on-disk files in |recovery|.
call dein#add('chrisbra/Recover.vim')
" Reads EditorConfig and sets various options accordingly.
call dein#add('editorconfig/editorconfig-vim', {
  \'hook_post_source': 'source ' . s:srcdir . '/editorconfig.vim',
  \})
" Git conflict marker manipulation.
call dein#add('rhysd/conflict-marker.vim')
" The package manager powering this very file.
call dein#add('Shougo/dein.vim')
" "Workspace Trust" manager.
call dein#add('tesaguri/trust.vim', {'hook_post_source': 'source ' . s:srcdir . '/trust.vim'})

" Vim plugin development:
" A package manager and a library with standard utilities.
" `:Vitalize` requires its runtimepath to be a git repository rather than a merged one.
call dein#add('vim-jp/vital.vim', {
  \'lazy': 1,
  \'on_cmd': 'Vitalize',
  \'on_ft': 'vim',
  \})
" External module collection for `vital`.
call dein#add('lambdalisue/vital-Whisky')

" Don't be too afraid of adding Neovim-specific plugins.
" I only use Vim in limited situations like through SSH and don't demand fancy things from it.
if has('nvim')
  " Language support:
  " Installs and configures various tree-sitter parsers.
  " The plugin installs parsers to its runtimepath and if it were merged, the parsers would be
  " overwritten by `dein#recache_runtimepath()`.
  call dein#add('nvim-treesitter/nvim-treesitter', {
    \'hook_post_source': 'luafile ' . s:srcdir . '/nvim-treesitter.lua',
    \'lazy': 1,
    \'on_ft': ['html', 'javascript', 'json', 'sh'],
    \})

  " LSP clients:
  " Collection of configurations for Neovim's built-in LSP client.
  call dein#add('neovim/nvim-lspconfig', {'lazy': 1, 'on_ft': ['dhall', 'lua', 'rust']})
  " Extra tools for `rust-analyzer` LSP client.
  call dein#add('simrat39/rust-tools.nvim', {
    \'depends': 'nvim-lspconfig',
    \'hook_post_source': 'luafile ' . s:srcdir . '/rust-tools.lua',
    \'lazy': 1,
    \'on_ft': 'rust',
    \})

  " An introduction `:help` text to Neovim's Lua interface.
  " Unlike `nvim-luaref`, this is specific to Neovim and does not make much sense outside it.
  call dein#add('nanotee/nvim-lua-guide')

  " `nvim-cmp` completion framework and its integrations:
  " The completion framework itself.
  call dein#add('hrsh7th/nvim-cmp', {'hook_post_source': 'luafile ' . s:srcdir . '/cmp.lua'})
  " Completion source for words in current buffer.
  call dein#add('hrsh7th/cmp-buffer')
  " Completion source for the built-in LSP client.
  call dein#add('hrsh7th/cmp-nvim-lsp', {'lazy': 1, 'on_source': 'nvim-lspconfig'})
  " I don't have much interest in snippet plugins. I picked one just because `nvim-cmp` requires it
  " and I may revisit it later.
  call dein#add('hrsh7th/cmp-vsnip')
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
