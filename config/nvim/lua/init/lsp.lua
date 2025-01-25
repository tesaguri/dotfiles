local M = {}

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

    function M.on_attach(_client, bufnr)
      local function buf_map(mode, lhs, rhs, opts)
        vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
      end
      buf_map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
      buf_map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
      buf_map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
      buf_map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      buf_map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
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
      buf_map("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    end

    local lua_path = vim.split(package.path, ";")
    table.insert(lua_path, "lua/?.lua")
    table.insert(lua_path, "lua/?/init.lua")

    local settings = {
      dhall_lsp_server = {},
      elmls = {},
      pyright = {},
      ts_ls = {},
      lua_ls = {
        -- Reference: `:help lspconfig-server-configurations`
        Lua = {
          runtime = { version = "LuaJIT", path = lua_path },
          diagnostics = { globals = { "vim" } },
          workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        },
      },
      -- rust_analyzer = --[[ settings live in `rust-tools.lua` ]],
    }

    for server, settings in pairs(settings) do
      lspconfig[server].setup {
        capabilities = capabilities,
        on_attach = M.on_attach,
        settings = settings,
      }
    end
  end)
end

return M
