local function on_ft_rust()
  -- Spawns `cmd` as a job and calls `f` with each line of its stdout.
  -- If `f` returns true, stops the iteration immediately.
  -- See also `:help channel-buffered`.
  local function job_for_each_line(cmd, f)
    local buf = ''
    local stop
    vim.fn.jobstart(cmd, {
      on_stdout = function(job, data)
        if stop then return end
        if #data > 1 then
          data[1] = buf..data[1]
          buf = table.remove(data)
          for _, line in pairs(data) do
            if f(line) then
              vim.fn.jobstop(job)
              stop = true
              return
            end
          end
        elseif data[1] == '' then -- EOF
          if buf ~= '' then f(buf) end
        else
          buf = data[1]
        end
      end,
      on_exit = function(job) if not stop and buf ~= '' then f(buf) end end,
    })
  end

  -- Add `rust-src` to `path`:
  vim.fn.jobstart({ 'rustup', 'show', 'active-toolchain' }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      local toolchain = data[1]
      if toolchain ~= '' then
        local toolchain = vim.fn.split(toolchain, ' ')[1]
        local rustup_home = vim.env.RUSTUP_HOME or vim.env.HOME..'/.rustup'
        job_for_each_line(
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
end

vim.g['on_ft_rust'] = on_ft_rust
vim.cmd('autocmd FileType rust ++once call g:on_ft_rust()')
