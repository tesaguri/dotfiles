-- Indent
vim.opt.copyindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.softtabstop = -1

-- Interface
vim.opt.clipboard:append('unnamedplus')
vim.opt.mouse = 'a'

-- Appearance
vim.opt.colorcolumn:append({ 101 })
vim.opt.termguicolors = true
vim.opt.winblend = 30

-- Add `rust-src` to `path`.
vim.opt.path:append(io.popen('rustup show home'):read()..'/toolchains/'..string.match(io.popen('rustup show active-toolchain'):read(), '[^ ]+')..'/lib/rustlib/src/rust/library')
