if ExecutableSuccess('xxd --version')
  " Edit the buffer as a hexadecimal byte string using xxd.
  " Adopted from |hex-editing|.
  command! -nargs=? -complete=file -bar Xxd
    \ call init#xxd#command(<f-args>)
endif
