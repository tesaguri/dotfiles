" Based on <https://vim.fandom.com/wiki/Moving_lines_up_or_down#Mappings_to_move_lines>,
" customized to accept counts and use `vim-repeat`.

function! init#mapping#move#normal#execute(count, map) abort
  execute ':m .' . (a:count >= 0 ? '+' . a:count : a:count - 1)
  " vint: next-line -ProhibitCommandRelyOnUser
  normal ==
  silent! call repeat#set(a:map, abs(a:count))
endfunction
