local M = {}

-- Spawns `cmd` as a job and calls `f` with each line of its stdout.
-- If `f` returns true, stops the iteration immediately.
-- See also `:help channel-buffered`.
function M.job_for_each_line(cmd, f)
  local buf = ""
  local stop
  vim.fn.jobstart(cmd, {
    on_stdout = function(job, data)
      if stop then
        return
      end
      if #data > 1 then
        data[1] = buf .. data[1]
        buf = table.remove(data)
        for _, line in pairs(data) do
          if f(line) then
            vim.fn.jobstop(job)
            stop = true
            return
          end
        end
      elseif data[1] == "" then -- EOF
        if buf ~= "" then
          f(buf)
        end
      else
        buf = data[1]
      end
    end,
    on_exit = function()
      if not stop and buf ~= "" then
        f(buf)
      end
    end,
  })
end

return M
