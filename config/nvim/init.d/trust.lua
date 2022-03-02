require("trust").load_state()

local lsp = require("trust.lsp")
lsp.safe_servers = { "dhall_lsp_server" }
lsp.hook_start_client()
