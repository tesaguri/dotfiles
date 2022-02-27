for _, chunk in pairs(vim.fn.glob(vim.fn.stdpath("config") .. "/init.d/**/*.lua", false, true)) do
  dofile(chunk)
end
