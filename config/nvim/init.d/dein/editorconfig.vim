if executable('editorconfig')
  let g:EditorConfig_core_mode = 'external_command'
  let g:EditorConfig_exec_path = 'editorconfig'
  " `editorconfig-vim` adds `tc` to `formatoptions` by default, but naive auto-wrap does not
  " necessarily work for every filetype (e.g. Vim script). Ftplugins handles it better.
  let g:EditorConfig_preserve_formatoptions = 1
endif
