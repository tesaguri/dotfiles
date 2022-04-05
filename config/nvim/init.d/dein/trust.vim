call add(g:trust#sources, 'trust#git#is_allowed')

call trust#path#load((empty($XDG_DATA_HOME) ? expand('~/.local/share') : $XDG_DATA_HOME) . '/trust.vim')

call trust#path#allow(expand('~/workspace'))
call trust#path#deny(expand('~/workspace/forks'))
call trust#path#allow(expand('~/.dotfiles'))

if has('nvim')
  call trust#lsp#set_safe_server('dhall_lsp_server')
  call trust#lsp#hook_start_client()
endif
