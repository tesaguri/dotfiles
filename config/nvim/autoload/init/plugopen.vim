function! init#plugopen#command(plugin, ...) abort
  let l:plugin = dein#get(a:plugin)
  if empty(l:plugin)
    throw 'PlugOpen: `' . a:plugin . '` not found'
  endif
  let l:rtp = l:plugin.rtp

  if a:0
    let l:file = l:rtp . '/' . a:1
  else
    let l:file = l:rtp . '/README'
    if !filereadable(l:file)
      let l:files = glob(l:rtp . '/README.*', 1, 1)
      if empty(l:files)
        throw 'PlugOpen: File name not supplied and README not found for `' . a:plugin . '`'
      endif
      let l:file = l:files[0]
    endif
    let l:help = 1
  endif

  if exists('l:help')
    " Replace a help window if any.
    if exists('*nvim_tabpage_list_wins')
      let l:wins = nvim_tabpage_list_wins(0)
    else
      let l:wins = gettabinfo(tabpagenr())[0].windows
    endif
    for l:win in l:wins
      if getbufvar(winbufnr(l:win), '&buftype') is# 'help'
        call win_execute(l:win, 'setlocal buftype=') " This is needed for ftdetect to work.
        call win_gotoid(l:win)
        let l:opened = 1
        break
      endif
    endfor
    if !exists('l:opened')
      split
    endif
  endif

  execute 'edit ' . fnameescape(l:file)
  setlocal nomodifiable readonly

  if exists('l:help')
    " Set `buftype` to `help` so that `:help` will replace the window.
    " (|'buftype'| help text discourages setting this manually, though)
    setlocal buftype=help
  endif
endfunction

function! init#plugopen#complete(lead, line, pos) abort
  let l:args = split(a:line[:a:pos])
  if len(l:args) <=# 1 || (len(l:args) is# 2 && a:line !~# '\s$')
    return filter(keys(dein#get()), {_, name -> empty(a:lead) || name[:len(a:lead)-1] is# a:lead })
  else
    let l:rtp = get(dein#get(l:args[1]), 'rtp')
    if l:rtp is# 0
      return []
    endif
    return map(
      \glob(l:rtp . '/' . a:lead . '*', 1, 1),
      \{_, path -> path[len(l:rtp)+1:] . (isdirectory(path) ? '/' : '')}
      \)
  endif
endfunction
