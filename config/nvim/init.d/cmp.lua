-- Reference: <https://github.com/hrsh7th/nvim-cmp/blob/main/README.md#recommended-configuration>

vim.fn['dein#source']('nvim-cmp')
local cmp = require('cmp')

vim.opt.completeopt = {
  'menu',
  'menuone',
  'noselect',
}

-- Helper function.
local if_visible = function(f)
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
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    -- Double press `<Esc>` to trigger the fallback behavior immidiately.
    ['<Esc><Esc>'] = function(fallback) fallback() end,
    ['<Esc>'] = cmp.mapping {
      i = if_visible(cmp.mapping.abort()),
    c = if_visible(cmp.mapping.close()),
    },
    ['<CR>'] = if_visible(cmp.mapping.confirm()),
    ['<Tab>'] = if_visible(cmp.mapping.confirm { select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
}

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' },
  },
})
