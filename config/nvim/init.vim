augroup vimrc
  autocmd!
augroup END

source <sfile>:h/util.vim

function s:Main(srcdir)
  for l:src in glob(a:srcdir . '/init.d/*.vim', 0, 1)
    execute 'source ' . fnameescape(l:src)
  endfor
endfunction

call s:Main(expand('<sfile>:h'))
delfunction s:Main
