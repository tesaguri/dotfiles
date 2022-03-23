-- Reference: <https://github.com/Shougo/dein.vim/blob/def7391/README.md#quick-start>

local base_path = vim.fn.stdpath("cache") .. "/dein"
local dein_path = base_path .. "/repos/github.com/Shougo/dein.vim"
vim.opt.runtimepath:append(dein_path)

vim.fn["dein#begin"](base_path)
local add = vim.fn["dein#add"]

-- List of plugins.
-- Be sure to execute the following command after editing this:
-- if dein#check_install() | call dein#install() | else | call dein#recache_runtimepath() | endif

add("chrisbra/Recover.vim")
add("editorconfig/editorconfig-vim")
add("euclidianAce/BetterLua.vim")
add("hrsh7th/cmp-buffer")
add("hrsh7th/cmp-nvim-lsp", { lazy = true, on_source = "nvim-lspconfig" })
add("hrsh7th/cmp-vsnip")
add("hrsh7th/nvim-cmp")
add("hrsh7th/vim-vsnip")
add("lambdalisue/vital-Whisky")
add("milisims/nvim-luaref")
add("nanotee/nvim-lua-guide")
add("neovim/nvim-lspconfig", { lazy = true, on_ft = { "dhall", "lua", "rust" } })
add("rhysd/conflict-marker.vim")
add("rust-lang/rust.vim", { lazy = true, on_ft = "rust" })
add("Shougo/dein.vim", { merged = true })
add("simrat39/rust-tools.nvim", { depends = "nvim-lspconfig", lazy = true, on_ft = "rust" })
add("tesaguri/trust.vim")
add("vim-jp/vital.vim", {
  -- `:Vitalize` requires its runtimepath to be a git repository rather than a merged one.
  lazy = true,
  on_cmd = "Vitalize",
  -- I want to experiment with it when editing a Vim script file.
  on_ft = "vim",
})
add("vmchale/dhall-vim")

vim.fn["dein#end"]()

vim.opt.runtimepath:remove(dein_path)
