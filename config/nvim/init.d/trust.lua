vim.cmd([[call add(g:trust#sources, 'trust#git#is_allowed')]])

local path = require("trust.path")

path.load()

local expand = vim.fn.expand

path.allow(expand("~/workspace"))
path.deny(expand("~/workspace/forks"))
path.allow(expand("~/.dotfiles"))

local lsp = require("trust.lsp")
lsp.safe_servers = { "dhall_lsp_server" }
lsp.hook_start_client()
