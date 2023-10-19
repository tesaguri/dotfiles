scriptencoding utf-8

if dein#is_sourced('trust.vim')
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
endif

if dein#is_sourced('vim-fugitive')
  function LightlineGitBranch()
    let l:head = fugitive#Head()
    return empty(l:head)
      \ ? ''
      \ : l:head . ' ' . (exists('b:init_git_allowed') ? (b:init_git_allowed ? '✔' : '✘') : '…')
  endfunction
endif

if dein#is_sourced('ale')
  function s:ale_diagnostics()
    let l:c = ale#statusline#Count(bufnr())
    return [l:c.error + l:c.style_error, l:c.warning + l:c.style_warning, l:c.info]
  endfunction
endif

if has('nvim')
  function s:diagnostics()
    if exists('*s:ale_diagnostics')
      let l:c = s:ale_diagnostics()
    else
      let l:c = [0, 0, 0]
    endif
    let l:c[0] += luaeval('#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.E })')
    let l:c[1] += luaeval('#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.W })')
    let l:c[2] += luaeval('#vim.diagnostic.get(0, { severity = vim.diagnostic.severity.I })')
    return l:c
  endfunction
elseif exists('*s:ale_diagnostics')
  let s:diagnostics = funcref('s:ale_diagnostics')
endif

if exists('*s:diagnostics')
  function LightlineDiagnostic()
    let l:c = s:diagnostics()
    return l:c[0] + l:c[1] + l:c[2] ? '× ' . l:c[0] . ' ⚠ ' . l:c[1] . ' i ' . l:c[2] : ''
  endfunction
endif

function LightlineCwd()
  return fnamemodify(getcwd(), ':~')
endfunction

" Print `fileformat` and `fileencoding` only for uncommon ones.
function LightlineFileFormat()
  return &fileformat is# 'unix' ? '' : &fileformat
endfunction

function LightlineFileEncoding()
  return (&fileencoding is# 'utf-8' || empty(&fileencoding)) ? '' : &fileencoding
endfunction

let s:lmid = []
if exists('*s:LightlineGitBranch')
  call add(s:lmid, 'gitbranch')
endif
call extend(s:lmid, ['readonly', 'relativepath', 'modified'])
if exists('*s:LightlineDiagnostic')
  call add(s:lmid, 'diagnostics')
endif

let g:lightline = {
  \'active': {
    \'left': [
      \['mode', 'paste'],
      \s:lmid,
      \['fileformat', 'fileencoding', 'filetype'],
      \],
    \'right': [
      \['lineinfo'],
      \['percent'],
      \['cwd'],
      \],
    \},
  \'component': {
    \'relativepath': '%f%{dein#is_sourced("trust.vim") ? (trust#path#is_allowed(expand("%")) ? " ✔" : " ✘") : ""}',
    \},
  \'component_function': {
    \'gitbranch': 'LightlineGitBranch',
    \'diagnostic': 'LightlineDiagnostic',
    \'fileformat': 'LightlineFileFormat',
    \'fileencoding': 'LightlineFileEncoding',
    \'cwd': 'LightlineCwd',
    \},
  \}
