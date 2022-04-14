scriptencoding utf-8

function s:set_git_trust(value)
  let b:init_git_allowed = a:value
endfunction

function s:update_git_trust()
  " The asynchronicity is crucial as the update takes tens of milliseconds (or a few centiseconds?).
  " XXX: Calling this seems to somehow cause the `:intro` message to disappear.
  call trust#git#async_is_allowed(FugitiveGitDir(), funcref('s:set_git_trust'))
endfunction

autocmd vimrc WinEnter,BufEnter,SessionLoadPost,FileChangedShellPost * call s:update_git_trust()
autocmd vimrc FileType qf call s:update_git_trust()

function LightlineGitBranch()
  let l:head = fugitive#head()
  return empty(l:head)
    \ ? ''
    \ : l:head . ' ' . (exists('b:init_git_allowed') ? (b:init_git_allowed ? '✔' : '✘') : '…')
endfunction

let g:lightline = {
  \'active': {
    \'left': [
      \['mode', 'paste'],
      \['gitbranch', 'readonly', 'relativepath', 'modified'],
      \],
    \},
  \'component': {
    \'relativepath': '%f %{trust#path#is_allowed(expand("%")) ? "✔" : "✘"}',
    \},
  \'component_function': {
    \'gitbranch': 'LightlineGitBranch',
    \},
  \}
