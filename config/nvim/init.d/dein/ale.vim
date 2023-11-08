if has('nvim')
  " Prefer the native LSP client.
  let g:ale_disable_lsp = 1
  let g:ale_linters = #{elm: [], rust: []}
endif

autocmd vimrc BufRead,BufNewFile */.github/*/*.y{,a}ml let b:ale_linters = {'yaml': ['actionlint']}
