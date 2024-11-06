-- Keeping all the parsers up-to-date doesn't sound like a super easy task.
-- Let's start with a small set of languages whose files tend to be absurdly large (i.e.
-- auto-generated) and are likely to benefit from tree-sitter the most.
local langs = { "bash", "html", "javascript", "json", "xml" }

-- Exclude parsers bundled with the Neovim installation.
local parsers = vim.call("glob", os.getenv("VIMRUNTIME") .. "/../../../lib/nvim/parser/*.so", 1, 1)
local bundled_langs = vim.tbl_map(function(p)
  return vim.call("fnamemodify", p, ":t:r")
end, parsers)
langs = vim.tbl_filter(function(l)
  return not vim.tbl_contains(bundled_langs, l)
end, langs)

require("nvim-treesitter.configs").setup {
  ensure_installed = langs,
  highlight = {
    -- It would be great if `enable` also accepted a list of parsers.
    enable = true,
  },
  indent = {
    enable = true,
  },
}
