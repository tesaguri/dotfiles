" Escape {string} for use as a value for |:set| (|option-backslash|).
function! SetEscape(string) abort
  return escape(a:string, ' \|"')
endfunction
