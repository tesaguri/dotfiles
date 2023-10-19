" Markdown {{{1
autocmd vimrc FileType markdown setlocal foldlevel=1

" Rust {{{1
autocmd vimrc FileType rust call init#filetype#rust#setup()

" Vim script {{{1
" Revert the setting of the built-in ftplugin.
autocmd vimrc BufWinEnter *.vim,vimrc if &textwidth is# 78 | setlocal textwidth=0 | endif
" }}}

" vim: foldmethod=marker foldlevel=1
