function! init#xxd#command(...) abort
  if a:0
    execute 'edit' '++bin' fnameescape(a:1)
  elseif &filetype is# 'xxd'
    return
  endif
  let l:columns = get(g:, 'xxdcolumns', 32)
  let l:savemod = &modified
  if !&binary
    setlocal binary
  endif
  execute 'silent' '%!' 'xxd' '-R' 'never' '-c' l:columns
  setlocal nobinary buftype=acwrite filetype=xxd
  if !l:savemod
    set nomodified
  endif
  execute 'autocmd' 'vimrc' 'BufWriteCmd' '<buffer>'
    \ 'silent let s:output = system('
      \ . ('''xxd -R never -r -c '''''' . ''' . l:columns . ''' . '''''' - '' . shellescape(expand(''<afile>'')),')
      \ 'getregion([0, 1, 1, 0],'
      \ 'getpos(''$''), {''type'': ''V''})'
      \ . ')'
    \ '| if v:shell_error'
      \ '| echo s:output'
      \ '| echo ''xxd: shell returned'' v:shell_error'
    \ '| else'
      \ '| set nomodified'
    \ '| endif'
  redraw
endfunction
