-- Reference: <https://github.com/hrsh7th/nvim-cmp/blob/main/README.md#recommended-configuration>

local cmp = require("cmp")

vim.opt.completeopt = {
  "menu",
  "menuone",
  "noselect",
}

-- Helper function.
local function if_visible(f)
  return function(fallback)
    if cmp.visible() then
      f(fallback)
    else
      fallback()
    end
  end
end

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-y>"] = cmp.mapping { i = if_visible(cmp.mapping.confirm()) },
    ["<C-e>"] = if_visible(cmp.mapping.abort()),
    ["<Tab>"] = if_visible(cmp.mapping.select_next_item()),
    ["<S-Tab>"] = if_visible(cmp.mapping.select_prev_item()),
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
  }, {
    { name = "buffer" },
  }),
}

cmp.setup.cmdline("/", {
  sources = {
    { name = "buffer" },
  },
})
