local trust = require("trust")
trust.load()

local expand = vim.fn.expand

trust.allow(expand("~/workspace"))
trust.deny(expand("~/workspace/forks"))
trust.allow(expand("~/.dotfiles"))

local lsp = require("trust.lsp")
lsp.safe_servers = { "dhall_lsp_server" }
lsp.hook_start_client()
