scriptencoding utf-8

if !has('nvim') && has('patch-8.0.1596')
  " <CR> to close a finished terminal buffer.
  autocmd vimrc TerminalOpen * nnoremap <buffer> <silent> <CR> :q<CR>
endif

" `:move` lines up/down.
nnoremap <silent> <M-J> :<C-U>call init#mapping#move(v:count1, "\<lt>M-J>")<CR>
nnoremap <silent> <M-K> :<C-U>call init#mapping#move(-v:count1, "\<lt>M-K>")<CR>
inoremap <silent> <M-J> <Esc>:call init#mapping#move(v:count1, "\<lt>M-J>")<CR>gi
inoremap <silent> <M-K> <Esc>:call init#mapping#move(-v:count1, "\<lt>M-K>")<CR>gi
vnoremap <silent> <M-J> :<C-U>call init#mapping#visual_move(v:count1, "\<lt>M-J>")<CR>
vnoremap <silent> <M-K> :<C-U>call init#mapping#visual_move(-v:count1, "\<lt>M-K>")<CR>
