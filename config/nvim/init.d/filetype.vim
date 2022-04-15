autocmd vimrc FileType rust call init#filetype#rust#setup()

" Revert the setting of built-in Vim ftplugin.
autocmd vimrc BufWinEnter *.vim,vimrc if &textwidth is# 78 | setlocal textwidth=0 | endif
