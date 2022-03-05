local trust = require("trust")
trust.load_state()

local expand = vim.fn.expand

trust.trust(expand("~/workspace"))
trust.distrust(expand("~/workspace/forks"))
trust.trust(expand("~/.dotfiles"))

local lsp = require("trust.lsp")
lsp.safe_servers = { "dhall_lsp_server" }
lsp.hook_start_client()
