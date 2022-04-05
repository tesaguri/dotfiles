let s:srcdir = expand('<sfile>:h')

augroup vimrc
  autocmd!
augroup END

function s:Main()
  for l:src in glob(s:srcdir . '/init.d/*.vim', 0, 1)
    execute 'source ' . l:src
  endfor
endfunction

call s:Main()
