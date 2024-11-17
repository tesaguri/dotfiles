" Escape {string} for use as a value for |:set| (|option-backslash|).
function! SetEscape(string) abort
  return escape(a:string, ' \|"')
endfunction

if match($HOME, '^/var/mobile/Containers/')
  " Like |executable()|, but checks if the {test} command succeeds on the quirky environment where
  " |executable()| may return true for unexecutable commands.
  function! ExecutableSuccess(test) abort
    if type(a:test) is# v:t_list
      let l:test = a:test
    else
      let l:test = split(a:test)
    endif
    if !executable(l:test[0])
      return 0
    endif
    silent call system(join(map(l:test, {_, arg -> shellescape(arg)}), ' ') . ' 2>&1 > /dev/null')
    return !v:shell_error
  endfunction
else
  function! ExecutableSuccess(test) abort
    if type(a:test) is# v:t_list
      let l:command = a:test[0]
    else
      let l:test = split(a:test)
      if len(l:test)
        let l:command = l:test[0]
      else
        let l:command = ''
      endif
    endif
    return executable(l:command)
  endfunction
endif
