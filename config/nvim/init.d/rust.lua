local util = require('init.util')

util.autocmd('FileType', 'rust', { once = true }, function()
  -- Add `rust-src` to `path`:
  vim.fn.jobstart({ 'rustup', 'show', 'active-toolchain' }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      local toolchain = data[1]
      if toolchain ~= '' then
        local toolchain = vim.fn.split(toolchain, ' ')[1]
        local rustup_home = vim.env.RUSTUP_HOME or vim.env.HOME..'/.rustup'
        util.job_for_each_line(
          { 'rustup', 'component', 'list', '--installed', '--toolchain', toolchain },
          function(line)
            if line == 'rust-src' then
              local src = rustup_home..'/toolchains/'..toolchain..'/lib/rustlib/src/rust/library'
              vim.opt.path:append(src)
              return true
            end
          end
        )
      end
    end,
  })

  vim.opt.path:append((vim.env.CARGO_HOME or vim.env.HOME..'/.cargo')..'/registry/src/github.com-1ecc6299db9ec823')
end)
