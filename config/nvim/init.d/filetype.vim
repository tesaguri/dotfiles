" Rust {{{1
if has('nvim') " It seems not be worth the trouble to make it compatible with Vim.
  function s:Rust()
    lua <<EOF
    local util = require("init.util")

    -- Add `rust-src` to `path`:
    vim.fn.jobstart({ "rustup", "show", "active-toolchain" }, {
      stdout_buffered = true,
      on_stdout = function(_, data)
        local toolchain = data[1]
        if toolchain ~= "" then
          local toolchain = vim.gsplit(toolchain, " ", true)()
          local rustup_home = vim.env.RUSTUP_HOME or vim.fn.expand("~/.rustup")
          util.job_for_each_line(
            { "rustup", "component", "list", "--installed", "--toolchain", toolchain },
            function(line)
              if line == "rust-src" then
                vim.opt.path:append(
                  rustup_home .. "/toolchains/" .. toolchain .. "/lib/rustlib/src/rust/library"
                )
                return true
              end
            end
          )
        end
      end,
    })

    local cargo_home = (vim.env.CARGO_HOME or vim.fn.expand("~/.cargo"))
    vim.opt.path:append(cargo_home .. "/registry/src/github.com-1ecc6299db9ec823")
EOF
  endfunction

  autocmd vimrc FileType * ++once call s:Rust()
endif
" }}}

" vim:fdm=marker
