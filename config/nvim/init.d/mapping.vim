scriptencoding utf-8

if !has('nvim') && has('patch-8.0.1596')
  " <CR> to close a finished terminal buffer.
  autocmd vimrc TerminalOpen * nnoremap <buffer> <silent> <CR> :q<CR>
endif

" `:move` lines up/down.
" The letter after |<M-| seems to be case-sensitive.
nnoremap <silent> <M-j> :<C-U>call init#mapping#move(v:count1, "\<lt>M-j>")<CR>
nnoremap <silent> <M-k> :<C-U>call init#mapping#move(-v:count1, "\<lt>M-k>")<CR>
inoremap <silent> <M-j> <Esc>:call init#mapping#move(v:count1, "\<lt>M-j>")<CR>gi
inoremap <silent> <M-k> <Esc>:call init#mapping#move(-v:count1, "\<lt>M-k>")<CR>gi
vnoremap <silent> <M-j> :<C-U>call init#mapping#visual_move(v:count1, "\<lt>M-j>")<CR>
vnoremap <silent> <M-k> :<C-U>call init#mapping#visual_move(-v:count1, "\<lt>M-k>")<CR>
