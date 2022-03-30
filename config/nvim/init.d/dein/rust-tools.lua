local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

require("rust-tools").setup {
  capabilities = capabilities,
  on_attach = require("init.lsp").on_attach,
  server = {
    settings = {
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
          "--warn",
          "clippy::pattern_type_mismatch",
          -- Too noisy because it warns the whole function.
          "--allow",
          "clippy::too_many_lines",
        },
      },
      diagnostics = {
        warningsAsHelp = {
          "clippy::pedantic",
          "clippy::pattern_type_mismatch",
        },
        warningsAsInfo = {
          -- I am not a big fan of this lint.
          "clippy::type_complexity",
        },
      },
    },
  },
}
