" Escape {string} for use as a value for |:set| (|option-backslash|).
function! SetEscape(string) abort
  return escape(a:string, ' \|"')
endfunction

if resolve($HOME) =~# '^/private/var/mobile/Containers/'
    \ && executable('/sbin/launchd')
    \ && [system('/sbin/launchd --help > /dev/null'), v:shell_error][1]
  " Running in a container on *OS but the sandbox is disabled, for some reason, so we can see
  " commands outside of the container like `launchd`, but we still cannot spawn the commands. In a
  " quirky environment like this, |executable()| is not useful as-is, hence the helper function:
 
  " Like |executable()|, but also checks if the {test} command succeeds.
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
