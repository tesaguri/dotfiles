scriptencoding utf-8

" `:move` lines up/down.
nnoremap <silent> <M-J> :<C-U>call init#mapping#move(v:count1, "\<lt>M-J>")<CR>
nnoremap <silent> <M-K> :<C-U>call init#mapping#move(-v:count1, "\<lt>M-K>")<CR>
inoremap <silent> <M-J> <Esc>:call init#mapping#move(v:count1, "\<lt>M-J>")<CR>gi
inoremap <silent> <M-K> <Esc>:call init#mapping#move(-v:count1, "\<lt>M-K>")<CR>gi
vnoremap <silent> <M-J> :<C-U>call init#mapping#visual_move(v:count1, "\<lt>M-J>")<CR>
vnoremap <silent> <M-K> :<C-U>call init#mapping#visual_move(-v:count1, "\<lt>M-K>")<CR>
