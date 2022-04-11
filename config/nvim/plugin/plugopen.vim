" Opens a file under a dein plugin directory (especially README).
command! -nargs=+ -complete=customlist,init#plugopen#complete PlugOpen
  \ call init#plugopen#command(<f-args>)
