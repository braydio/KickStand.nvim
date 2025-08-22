-- Configures language servers via lspconfig and mason.

return {
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    config = true,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = {
      ensure_installed = { 'pyright', 'lua_ls' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      lspconfig.pyright.setup { capabilities = capabilities }
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
          },
        },
      }
    end,
  },
}
