function! s:Main() abort
  " Tweaks for Neovim's new default color scheme.
  if !empty(findfile('vim.lua', $VIMRUNTIME . '/colors'))
    " Respect the background color/transparency setting of the terminal.
    highlight Normal guibg=NONE ctermbg=NONE

    if &background is# 'light'
      highlight LineNr guifg=NvimDarkBlue ctermfg=Cyan
    else
      " The default color (`NvimDarkGrey4`) is hard to recognize on a translucent terminal.
      highlight LineNr guifg=NvimLightBlue ctermfg=Cyan
    endif
  endif
endfunction

call s:Main()
delfunction s:Main
