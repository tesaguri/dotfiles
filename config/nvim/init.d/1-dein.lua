-- Reference: <https://github.com/Shougo/dein.vim/blob/def7391/README.md#quick-start>

local cache_home = os.getenv('XDG_CACHE_HOME')
if not(cache_home) or cache_home == '' then
  cache_home = os.getenv('HOME')..'/.cache'
end
local base_path = cache_home..'/dein'

-- Install dein.
local dein_repo = base_path..'/repos/github.com/Shougo/dein.vim'
if not vim.fn.isdirectory(dein_repo) then
  os.execute('git clone https://github.com/Shougo/dein.vim.git '..vim.fn.shellescape(vim.fn.escape(dein_repo)))
end
vim.opt.runtimepath:append(dein_repo)

-- Load plugins.
if not(vim.fn['dein#load_state'](base_path) == 0) then
  vim.fn['dein#begin'](base_path)
  local add = vim.fn['dein#add']

  -- List of plugins.
  -- Be sure to call `dein#install()` or `dein#recache_runtimepath()` as appropriate
  -- after editing this.

  add('chrisbra/Recover.vim')
  add('editorconfig/editorconfig-vim')
  add('hrsh7th/cmp-buffer')
  add('hrsh7th/cmp-nvim-lsp', { lazy = true, on_source = 'nvim-lspconfig' })
  add('hrsh7th/cmp-vsnip')
  add('hrsh7th/nvim-cmp')
  add('hrsh7th/vim-vsnip')
  add('milisims/nvim-luaref')
  add('neovim/nvim-lspconfig', { lazy = true, on_ft = { 'dhall', 'rust' } })
  add('rust-lang/rust.vim', { lazy = true, on_ft = 'rust' })
  add('Shougo/dein.vim')
  add('vmchale/dhall-vim')

  vim.fn['dein#end']()
  vim.fn['dein#save_state']()
end
