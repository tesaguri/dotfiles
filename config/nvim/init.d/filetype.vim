" Rust {{{1
function s:Rust()
  if !exists('s:crates_io_src')
    let l:cargo_home = empty($CARGO_HOME) ? expand('~/.cargo') : $CARGO_HOME
    let s:crates_io_src = l:cargo_home . '/registry/src/github.com-1ecc6299db9ec823'
  endif
  execute 'setlocal path+=' . s:crates_io_src

  " Add `rust-src` to `path`:
  if exists('s:rust_src')
    execute 'setlocal path+=' . s:rust_src
  elseif exists('*jobstart')
    function! s:rustup_show_on_stdout(_job, data, _event)
      let l:toolchain = a:data[0]
      if empty(l:toolchain)
        return
      endif
      let l:toolchain = split(l:toolchain)[0]
      let l:rustup_home = empty($RUSTUP_HOME) ? expand('~/.rustup') : $RUSTUP_HOME
      let s:rust_src =
        \l:rustup_home .. '/toolchains/' .. l:toolchain .. '/lib/rustlib/src/rust/library'
      execute 'setlocal path+=' .. s:rust_src
    endfunction

    call jobstart(['rustup', 'show', 'active-toolchain'], #{
      \stdout_buffered: 1,
      \on_stdout: funcref('s:rustup_show_on_stdout'),
      \})
  endif
endfunction
autocmd vimrc FileType rust call s:Rust()
" }}}

" vim:fdm=marker
