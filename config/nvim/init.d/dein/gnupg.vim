function! s:Main() abort
  let l:conf = (empty($GNUPGHOME) ? expand('~/.gnupg') : $GNUPGHOME) . '/gpg.conf'

  if filereadable(l:conf)
    for l:line in readfile(l:conf)
      if exists('*trim')
        let l:line = trim(l:line)
      endif
      if l:line is# 'default-recipient-self'
        let l:default_recipient = 1
        continue
      endif
      let l:match = matchlist(l:line, '^\%(default-key\s\s*\(.*\)\|default-recipient\s\s*\(.*\)\)$')
      if !empty(l:match)
        if !empty(l:match[1])
          let l:default_key = l:match[1]
        elseif !empty(l:match[2])
          let l:default_recipient = l:match[2]
        endif
      endif
    endfor
  endif

  if exists('l:default_recipient')
    if type(l:default_recipient) is# v:t_string
      let g:GPGDefaultRecipients = [l:default_recipient]
    elseif exists('l:default_key')
      let g:GPGDefaultRecipients = [l:default_key]
    else
      " TODO: Use the first key from the secret keyring as described in `man 1 gpg`.
    endif
  endif
endfunction

call s:Main()
delfunction s:Main
