local lsp_zero = require("lsp-zero")
local cfg = require("lspconfig")

cfg.rust_analyzer.setup({})
cfg.dartls.setup({})
cfg.taplo.setup({})
cfg.lua_ls.setup({})
cfg.clangd.setup({})


require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        "dockerls",
        "marksman",
        "sqlls",
    },
    handlers = {
        lsp_zero.default_setup,
    },
})
