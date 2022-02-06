" Reference: <https://github.com/hrsh7th/nvim-cmp/blob/main/README.md#recommended-configuration>

set completeopt=menu,menuone,noselect

lua <<EOF
  local cmp = require('cmp')

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
      ['<Esc><Esc>'] = function(fallback)
        fallback()
      end,
      ['<Esc>'] = cmp.mapping({
        i = if_visible(cmp.mapping.abort()),
        c = if_visible(cmp.mapping.close()),
      }),
      ['<CR>'] = if_visible(cmp.mapping.confirm()),
      ['<Tab>'] = if_visible(cmp.mapping.confirm({ select = true })),
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

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  require('lspconfig').rust_analyzer.setup {
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        assist = {
          allowMergingIntoGlobImports = false,
          importGranularity = "module",
        },
        cargo = {
          allFeatures = true,
        },
        checkOnSave = {
          command = "clippy",
          extraArgs = {
            "--",
            "--warn",
            "rust_2018_idioms",
            "--warn",
            "clippy::pedantic",
            -- Too noisy because it warns the whole function.
            "--allow",
            "clippy::too_many_lines",
          },
        },
        diagnostics = {
          warningsAsHelp = {
            "clippy::pedantic",
          },
          warningsAsInfo = {
            -- I am not a big fan of this lint.
            "clippy::type_complexity",
          },
        },
      },
    },
  }
EOF
