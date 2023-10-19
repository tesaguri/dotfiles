let s:srcdir = expand('<sfile>:h')

augroup vimrc
  autocmd!
augroup END

execute 'source ' . fnameescape(s:srcdir . '/util.vim')

function s:Main()
  for l:src in glob(s:srcdir . '/init.d/*.vim', 0, 1)
    execute 'source ' . fnameescape(l:src)
  endfor
endfunction

call s:Main()
