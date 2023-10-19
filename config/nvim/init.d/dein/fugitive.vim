" Emulate |fugitive_gq| in terminal windows opened by Fugitive commands like `:Git add -p`.
if !has('nvim') && has('patch-8.0.1596')
  autocmd vimrc TerminalOpen !git nnoremap <buffer> <silent> gq :q<CR>
endif
