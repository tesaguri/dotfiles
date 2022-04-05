if executable('editorconfig')
  let g:EditorConfig_core_mode = 'external_command'
  let g:EditorConfig_exec_path = 'editorconfig'
  " Auto-wrap sometimes breaks things.
  let g:EditorConfig_preserve_formatoptions = 1
endif
