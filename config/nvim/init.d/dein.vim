" Reference: `:help dein-examples`

" Prelude {{{1
let s:base_path = (empty($XDG_DATA_HOME) ? expand('~/.local/share') : $XDG_DATA_HOME) . '/dein'
let g:dein#cache_directory = (empty($XDG_CACHE_HOME)
  \ ? expand('~/.cache')
  \ : $XDG_CACHE_HOME) . '/dein'

let s:dein_path = s:base_path . '/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath+=' . SetEscape(s:dein_path)

let s:srcdir = expand('<sfile>:h') . '/dein'

if dein#min#load_state(s:base_path)
  call dein#begin(s:base_path)

  " List of plugins {{{1
  " Language support {{{2
  " Lua syntax that aims at being better than built-in one.
  " Specifically, it highlights EmmyLua annotations nicely.
  call dein#add('euclidianAce/BetterLua.vim')
  " Adds the Lua 5.1 Reference Manual to `:help`.
  " Despite the plugin's name, Lua Reference Manual is useful outside Neovim too.
  call dein#add('milisims/nvim-luaref')
  " Syntax and key mappings for Markdown.
  call dein#add('preservim/vim-markdown', {'hook_source': 'source ' . s:srcdir . '/markdown.vim'})
  " Syntax and ftplugin for Rust, the best systems programming language ever.
  call dein#add('rust-lang/rust.vim', {'lazy': 1, 'on_ft': 'rust'})
  " Syntax for Dhall, a programmable configuration language.
  call dein#add('vmchale/dhall-vim')

  " LilyPond, the GNU music engraving program, bundles a Vim plugin with it.
  for s:rtp in glob('/usr/local/share/lilypond/*/vim', 1, 1)
    call dein#add(s:rtp, {'merged': 1, 'name': 'lilypond'})
    " Sourcing one version should be enough.
    " (dein would overwrite the runtime files while merging the runtimepath otherwise)
    break
  endfor

  " Editor utilities {{{2
  if ExecutableSuccess('git --version')
    " Shows Git diffs as |signs|.
    call dein#add('airblade/vim-gitgutter')
    " Git wrapper that should be illegal.
    call dein#add('tpope/vim-fugitive', {'hook_source': 'source ' .s:srcdir . '/fugitive.vim'})
  endif
  " Shows diff between the swap and on-disk files in |recovery|.
  call dein#add('chrisbra/Recover.vim')
  if ExecutableSuccess('tmux -V')
    " Key mappings for consistent navigation between Vim windows and tmux panes.
    call dein#add('christoomey/vim-tmux-navigator')
  endif
  " Runs various linters and sets |signs| asynchronously.
  call dein#add('dense-analysis/ale')
  " Reads EditorConfig and sets various options accordingly.
  call dein#add('editorconfig/editorconfig-vim', {
        \'hook_source': 'source ' . s:srcdir . '/editorconfig.vim',
        \})
  " `statusline` and `tabline` manager.
  " You need to either define `g:lightline` before `lightline` is sourced or call `lightline#init()`
  " after defining `g:lightline`.
  call dein#add('itchyny/lightline.vim', {'hook_source': 'source ' . s:srcdir . '/lightline.vim'})
  if ExecutableSuccess('gpg --version')
    " Transparent editing of GPG encrypted files.
    call dein#add('jamessan/vim-gnupg', {'hook_source': 'source ' . s:srcdir . '/gnupg.vim'})
  endif
  " Git conflict marker manipulation.
  call dein#add('rhysd/conflict-marker.vim')
  " Filesystem browser.
  call dein#add('scrooloose/nerdtree')
  " The package manager powering this very file.
  call dein#add('Shougo/dein.vim')
  " Adds `:AsyncRun` command to run shell commands asynchronously.
  call dein#add('skywind3000/asyncrun.vim')
  " "Workspace Trust" manager.
  call dein#add('tesaguri/trust.vim', {'hook_post_source': 'source ' . s:srcdir . '/trust.vim'})
  " Key mappings for exchanging a pair of texts.
  call dein#add('tommcdo/vim-exchange')
  " Key mappings for commenting out and uncommenting.
  call dein#add('tomtom/tcomment_vim')
  " Framework to allow plugin mappings to be repeated by the `.` command.
  call dein#add('tpope/vim-repeat')
  " |text-object| like key mappings for editing "surroundings" (like pairs of parentheses).
  call dein#add('tpope/vim-surround')

  " I like matchit plugin but I don't like the way Neovim adds it to runtimepath by default nor the
  " editor's recommended way of disabling it (i.e. `:let loaded_matchit = 1` in vimrc, which is not
  " true! Other plugins would be confused by it).
  if has('nvim') || has('patch-8.1.1114') " Upstream `matchit` now uses `..` operator.
    call dein#add('chrisbra/matchit')
  else
    " Use the version of matchit bundled with Vim 8 (|matchit-install|).
    let s:rtp = globpath(&packpath, 'pack/dist/opt/matchit', 1, 1)
    if !empty(s:rtp)
      call dein#add(s:rtp[0])
    endif
  endif

  " Vim plugin development {{{2
  " Test framework for Vim script.
  call dein#add('thinca/vim-themis')
  " A package manager and a library with standard utilities.
  " `:Vitalize` requires its runtimepath to be a git repository rather than a merged one.
  call dein#add('vim-jp/vital.vim', {
        \'lazy': 1,
        \'on_cmd': 'Vitalize',
        \'on_ft': 'vim',
        \})
  " External module collection for `vital`.
  call dein#add('lambdalisue/vital-Whisky')

  " Neovim-specific plugins {{{2
  " Don't be too afraid of adding plugins here.
  " I only use Vim in limited situations like through SSH and don't demand fancy things from it.
  if has('nvim')
    " Language support {{{3
    " An introduction `:help` text to Neovim's Lua interface.
    " Unlike `nvim-luaref`, this is specific to Neovim and does not make much sense outside it.
    call dein#add('nanotee/nvim-lua-guide')
    " Installs and configures various tree-sitter parsers.
    " The plugin installs parsers to its runtimepath and if it were merged, the parsers would be
    " overwritten by `dein#recache_runtimepath()`.
    call dein#add('nvim-treesitter/nvim-treesitter', {
          \'hook_post_source': 'luafile ' . s:srcdir . '/nvim-treesitter.lua',
          \'lazy': 1,
          \'on_ft': ['html', 'javascript', 'json', 'sh', 'xml'],
          \})

    " LSP clients {{{3
    " Collection of configurations for Neovim's built-in LSP client.
    call dein#add('neovim/nvim-lspconfig', {'lazy': 1, 'on_ft': ['dhall', 'lua', 'rust']})
    " Extra tools for `rust-analyzer` LSP client.
    call dein#add('simrat39/rust-tools.nvim', {
          \'depends': 'nvim-lspconfig',
          \'hook_post_source': 'luafile ' . s:srcdir . '/rust-tools.lua',
          \'lazy': 1,
          \'on_ft': 'rust',
          \})

    " `nvim-cmp` completion framework and its integrations {{{3
    " The completion framework itself.
    call dein#add('hrsh7th/nvim-cmp', {'hook_post_source': 'luafile ' . s:srcdir . '/cmp.lua'})
    " Completion source for words in current buffer.
    call dein#add('hrsh7th/cmp-buffer')
    " Completion source for the built-in LSP client.
    call dein#add('hrsh7th/cmp-nvim-lsp', {'lazy': 1, 'on_source': 'nvim-lspconfig'})
    " I don't have much interest in snippet plugins. I picked one just because `nvim-cmp` requires
    " it and I may revisit it later.
    call dein#add('hrsh7th/cmp-vsnip')
    call dein#add('hrsh7th/vim-vsnip')
  endif

  " Postlude {{{1
  call dein#end()
  call dein#save_state()
endif
call dein#call_hook('source')

" Install new packages when this file is modified.
execute 'autocmd vimrc BufWritePost ' . fnameescape(resolve(expand('<sfile>'))) . ' ++once'
  \ . ' source ' . fnameescape(expand('<sfile>'))
  \ . ' | if dein#check_install()'
  \ . ' | call dein#install()'
  \ . ' | endif'

if has('vim_starting')
  " See `:help dein-options-hook_post_source`.
  autocmd vimrc VimEnter * call dein#call_hook('post_source')
endif

if !has('nvim')
  " Although |defaults.vim| executes `:filetype on`, |dein#begin()| executes `:filetype off`.
  " Dein resets back the options only on Neovim (|dein-compatibility|, 2022.12.06).
  filetype on
endif

" vim: fdm=marker
