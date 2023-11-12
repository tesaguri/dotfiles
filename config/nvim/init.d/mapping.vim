scriptencoding utf-8

if !has('nvim') && has('patch-8.0.1596')
  " <CR> to close a finished terminal buffer.
  autocmd vimrc TerminalOpen * nnoremap <buffer> <CR> <Cmd>q<CR>
endif

" `:move` lines up/down.
" The letter after |<M-| seems to be case-sensitive.
nnoremap <M-j> <Cmd>call init#mapping#move#normal#execute(v:count1, "\<lt>M-j>")<CR>
nnoremap <M-k> <Cmd>call init#mapping#move#normal#execute(-v:count1, "\<lt>M-k>")<CR>
inoremap <M-j> <Cmd>call init#mapping#move#normal#execute(v:count1, "\<lt>M-j>")<CR><Cmd>normal gi<CR>
inoremap <M-k> <Cmd>call init#mapping#move#normal#execute(-v:count1, "\<lt>M-k>")<CR><Cmd>normal gi<CR>
vnoremap <silent> <M-j> :<C-U>call init#mapping#move#visual#execute(v:count1, "\<lt>M-j>")<CR>
vnoremap <silent> <M-k> :<C-U>call init#mapping#move#visual#execute(-v:count1, "\<lt>M-k>")<CR>
