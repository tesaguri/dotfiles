-- Keeping all the parsers up-to-date doesn't sound like a super easy task.
-- Let's start with a small set of languages whose files tend to be absurdly large (i.e.
-- auto-generated) and are likely to benefit from tree-sitter the most.
local langs = { "bash", "html", "javascript", "json", "xml" }

require("nvim-treesitter.parsers").list.xml = {
  install_info = {
    url = "https://github.com/unhammer/tree-sitter-xml",
    files = { "src/parser.c" },
  },
}

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
