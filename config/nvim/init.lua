for _, chunk in pairs(vim.fn.glob(vim.fn.stdpath("config") .. "/init.d/**/*.lua", false, true)) do
  local success, err = pcall(function()
    dofile(chunk)
  end)
  if not success then
    print(err)
  end
end
