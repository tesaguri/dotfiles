let g:NERDTreeShowHidden = 1

" Put Rust module files next to corresponding module directories.
let NERDTreeSortOrder = ['\%(\/\|\.rs\)$', '*']

" Open NERDTree when starting the editor with no file arguments on a workspace.
autocmd vimrc VimEnter *
  \ if empty(expand('%')) && (!empty(FugitiveGitDir()) || filereadable('Cargo.toml'))
  \   && fnamemodify(bufname(), ':t') isnot# 'COMMIT_EDITMSG'
  \ | let s:buf = bufnr()
  \ | let s:win = win_getid()
  \ | NERDTreeVCS
  \ | if !empty(bufname(s:buf))
  \ | call win_gotoid(s:win)
  \ | endif
