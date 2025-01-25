function! s:Init()
  " Calling |system()| without checking |executable()| because `umask` is usually implemented as a
  " shell built-in and |executable()| cannot detect the shell built-in while |system()| can execute
  " it.
  let l:umask = system('umask')
  if !v:shell_error
    let l:umask = invert(str2nr(l:umask, 8))
    let l:umask_symbols = ''
    while len(l:umask_symbols) < 9
      let l:umask_symbols .= and(l:umask, 0400) ? '.' : '-'
      let l:umask *= 2
    endwhile
    unlet l:umask
    let s:umask_symbols = l:umask_symbols
  else
    let s:umask_symbols = 'rwxr-xr-x'
  endif
endfunction
call s:Init()
delfunction s:Init

" Returns the umask as a symbolic mode string for |setfperm()|.
function! init#filetype#sh#umask_symbols() abort
  return s:umask_symbols
endfunction
