let s:conf = (empty($GNUPGHOME) ? expand('~/.gnupg') : $GNUPGHOME) . '/gpg.conf'

if filereadable(s:conf)
  for s:line in readfile(s:conf)
    if exists('*trim')
      let s:line = trim(s:line)
    endif
    if s:line is# 'default-recipient-self'
      let s:default_recipient = 1
      continue
    endif
    let s:match = matchlist(s:line, '^\%(default-key\s\s*\(.*\)\|default-recipient\s\s*\(.*\)\)$')
    if !empty(s:match)
      if !empty(s:match[1])
        let s:default_key = s:match[1]
      elseif !empty(s:match[2])
        let s:default_recipient = s:match[2]
      endif
    endif
  endfor
endif

if exists('s:default_recipient')
  if type(s:default_recipient) is# v:t_string
    let g:GPGDefaultRecipients = [s:default_recipient]
  elseif exists('s:default_key')
    let g:GPGDefaultRecipients = [s:default_key]
  else
    " TODO: Use the first key from the secret keyring as described in `man 1 gpg`.
  endif
endif
