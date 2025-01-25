if has('nvim')
  lua << EOF
-- Reference: `:help lspconfig-keybindings`
local opts = { noremap = true, silent = true }
local map = vim.api.nvim_set_keymap
map("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
map("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

if vim.call("dein#is_available", "nvim-lspconfig") ~= 0 then
  vim.call("dein#set_hook", "nvim-lspconfig", "hook_source", function()
    local lspconfig = require("lspconfig")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local function on_attach(client, bufnr)
      local function buf_map(mode, lhs, rhs, opts)
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
      end
      buf_map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      buf_map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      buf_map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      buf_map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      -- TODO: Come up with a good mapping which doesn't confilict with tmux-navigator's one.
      -- buf_map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
      buf_map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
      buf_map("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
      buf_map(
        "n",
        "<space>wl",
        "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
        opts
      )
      buf_map("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
      buf_map("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
      buf_map("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
      buf_map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
      buf_map("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
      if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    end

    local lua_path = vim.split(package.path, ";")
    table.insert(lua_path, "lua/?.lua")
    table.insert(lua_path, "lua/?/init.lua")

    local M = {}

    local settings = {
      dhall_lsp_server = {},
      elmls = {},
      pyright = {},
      rust_analyzer = {
        handlers = {
          -- Work around inlay hints not displaying for the first attached buffer.
          -- <https://www.reddit.com/r/neovim/comments/17889r8/>
          -- <https://github.com/simrat39/rust-tools.nvim/blob/66374d4/lua/rust-tools/server_status.lua>
          ["experimental/serverStatus"] = function(_, result, ctx, _)
            if result.quiescent and not M.ran_once then
              for _, bufnr in ipairs(vim.lsp.get_buffers_by_client_id(ctx.client_id)) do
                vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
              end
              M.ran_once = true
            end
          end
        },
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
      },
      ts_ls = {},
      lua_ls = {
        settings = {
          -- Reference: `:help lspconfig-server-configurations`
          Lua = {
            runtime = { version = "LuaJIT", path = lua_path },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
          },
        },
      },
    }

    for server, opts in pairs(settings) do
      lspconfig[server].setup(vim.tbl_extend("keep", opts, {
        capabilities = capabilities,
        on_attach = on_attach,
      }))
    end
  end)
end
EOF
endif
