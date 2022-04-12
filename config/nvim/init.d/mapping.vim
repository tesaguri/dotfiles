scriptencoding utf-8

" `:move` lines up/down.
nnoremap <silent> <M-J> :<C-U>call init#mapping#move(v:count1, "\<lt>M-J>")<CR>
nnoremap <silent> <M-K> :<C-U>call init#mapping#move(-v:count1, "\<lt>M-K>")<CR>
inoremap <silent> <M-J> <Esc>:call init#mapping#move(v:count1, "\<lt>M-J>")<CR>gi
inoremap <silent> <M-K> <Esc>:call init#mapping#move(-v:count1, "\<lt>M-K>")<CR>gi
vnoremap <silent> <M-J> :<C-U>call init#mapping#visual_move(v:count1, "\<lt>M-J>")<CR>
vnoremap <silent> <M-K> :<C-U>call init#mapping#visual_move(-v:count1, "\<lt>M-K>")<CR>

if has('mac')
  " On macOS, when you modify a key with Option, the input will be a fancy Unicode character.
  " But you usually don't want it outside certain modes, so let's remap them to <M-...>.
  let s:code = char2nr('A')
  for s:char in split('å∫ç∂´ƒ©˙ˆ∆˚¬µ˜øπœ®ß†¨√∑≈¥Ω', '\zs')
    execute 'nmap ' . s:char . ' <M-' . nr2char(s:code) . '>'
    execute 'xmap ' . s:char . ' <M-' . nr2char(s:code) . '>'
    execute 'omap ' . s:char . ' <M-' . nr2char(s:code) . '>'
    let s:code += 1
  endfor
endif
