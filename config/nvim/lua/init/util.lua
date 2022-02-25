local M = {}

-- Spawns `cmd` as a job and calls `f` with each line of its stdout.
-- If `f` returns true, stops the iteration immediately.
-- See also `:help channel-buffered`.
function M.job_for_each_line(cmd, f)
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

local autocmds = {}

function M.autocmd(event, pat, opts, cmd)
  local opts = opts or {}

  local args = 'autocmd '..event..' '..pat
  if opts.once then
    args = args..' ++once'
  end
  if opts.nested then
    args = args..' ++nested'
  end

  if type(cmd) == 'function' then
    local fptr
    if opts.once then
      local cmd = function()
        cmd()
        autocmds[fptr] = nil
      end
      -- Generate `fptr` key from local `cmd` instead of argument `cmd` to prevent using
      -- `autocmds[fptr]` after freeing when calling `M.autocmd` with same function multiple times.
      fptr = tonumber(('%p'):format(cmd))
      autocmds[fptr] = cmd
    else
      fptr = tonumber(('%p'):format(cmd))
      autocmds[fptr] = cmd
    end
    vim.cmd(args.." lua require('init.util')._au_call("..fptr..')')
  else
    vim.cmd(args..' '..cmd)
  end
end

function M._au_call(fptr)
  autocmds[fptr]()
end

return M
