-- Simple Mason and LSP config for Python

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "pyright" },  -- Installs the Python LSP
}

-- Enable LSP for Python
require("lspconfig").pyright.setup {}

-- nvim-cmp setup for autocompletion
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
})

