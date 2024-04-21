" Markdown {{{1
autocmd vimrc FileType markdown setlocal foldlevel=1

" Shell {{{1
if executable('umask')
  let s:umask = invert(str2nr(system('umask'), 8))
  let s:execmode = ''
  while len(s:execmode) < 9
    let s:execmode .= and(s:umask, 0400) ? '.' : '-'
    let s:umask *= s:umask
  endwhile
  unlet s:umask
else
  let s:execmode = 'rwxr-xr-x'
endif
" Use the literal tab character, and set the execute mode bit when writing to a new file.
autocmd vimrc FileType sh
  \ setlocal noexpandtab shiftwidth=0
  \ | if empty(glob(expand('%')))
    \ | execute 'autocmd vimrc BufWritePost <buffer> ++once call setfperm(expand(''%''), ''' . s:execmode . ''')'
  \ | endif

" Ruby {{{1
" Don't try to align indentation in `foo = if bar ...` blocks.
autocmd vimrc FileType ruby setlocal nosmartindent

" Rust {{{1
autocmd vimrc FileType rust call init#filetype#rust#setup()

" Shell {{{1
autocmd vimrc FileType sh setlocal
  \ noexpandtab
  \ shiftwidth=0
  \ tabstop=4

" Vim script {{{1
" Revert the setting of the built-in ftplugin.
autocmd vimrc BufWinEnter *.vim,vimrc if &textwidth is# 78 | setlocal textwidth=0 | endif

" }}}1

" vim: foldmethod=marker foldlevel=1
