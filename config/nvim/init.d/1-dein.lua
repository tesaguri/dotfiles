-- References:
-- - <https://github.com/Shougo/dein.vim/blob/def7391/README.md#quick-start>
-- - <https://qiita.com/kawaz/items/ee725f6214f91337b42b>

-- Install dein.
local cache_home = os.getenv('XDG_CACHE_HOME')
if cache_home == nil or cache_home == '' then
  cache_home = os.getenv('HOME')..'/.cache'
end
local dein_dir = cache_home..'/dein'
local dein_repo_dir = dein_dir..'/repos/github.com/Shougo/dein.vim'
if not vim.fn.isdirectory(dein_repo_dir) then
  os.execute('git clone https://github.com/Shougo/dein.vim.git '..vim.fn.shellescape(vim.fn.escape(dein_repo_dir)))
end
vim.opt.runtimepath:prepend(dein_repo_dir)

-- Load plugins.
if not(vim.fn['dein#load_state'](dein_dir) == 0) then
  vim.fn['dein#begin'](dein_dir)
  toml_dir = vim.fn.stdpath('config')..'/dein'
  vim.fn['dein#load_toml'](toml_dir..'/dein.toml')
  vim.fn['dein#load_toml'](toml_dir..'/lazy.toml', { lazy = 1 })
  vim.fn['dein#end']()
  vim.fn['dein#save_state']()
end

if not (vim.fn.has('vim_starting') == 0) and not (vim.fn['dein#check_install']() == 0) then
  vim.fn['dein#install']()
end
