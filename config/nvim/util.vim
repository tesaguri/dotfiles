" Escape {string} for use as a value for |:set| (|option-backslash|).
function! SetEscape(string) abort
  return escape(a:string, ' \|"')
endfunction

if match($HOME, '^/var/mobile/Containers/')
  " Like |executable()|, but checks if the {test} command succeeds on the quirky environment where
  " |executable()| may return true for unexecutable commands.
  function! ExecutableSuccess(test) abort
    if !executable(split(a:test)[0])
      return 0
    endif
    call system(a:test . ' > /dev/null')
    return !v:shell_error
  endfunction
else
  function! ExecutableSuccess(test) abort
    return executable(split(a:test)[0])
  endfunction
endif
