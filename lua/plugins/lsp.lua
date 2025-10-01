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
      ensure_installed = { 'pyright', 'lua_ls', 'yamlls' },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'b0o/schemastore.nvim' },
    config = function()
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local map = function(mode, lhs, rhs, desc, bufnr)
        vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = bufnr })
      end

      local function try_telescope(func_name, fallback)
        return function()
          local ok, builtin = pcall(require, 'telescope.builtin')
          if ok and builtin[func_name] then
            builtin[func_name]()
          else
            fallback()
          end
        end
      end

      local on_attach = function(client, bufnr)
        -- LSP core
        map('n', 'gd', vim.lsp.buf.definition, 'LSP: Go to definition', bufnr)
        map('n', 'gD', vim.lsp.buf.declaration, 'LSP: Go to declaration', bufnr)
        map('n', 'gi', vim.lsp.buf.implementation, 'LSP: Go to implementation', bufnr)
        map('n', 'gr', try_telescope('lsp_references', vim.lsp.buf.references), 'LSP: References', bufnr)
        map('n', 'K', vim.lsp.buf.hover, 'LSP: Hover', bufnr)
        map('n', '<leader>lr', vim.lsp.buf.rename, 'LSP: Rename', bufnr)
        map('n', '<leader>la', vim.lsp.buf.code_action, 'LSP: Code action', bufnr)
        map('n', '<leader>ld', try_telescope('diagnostics', function() vim.diagnostic.setloclist() end), 'LSP: Diagnostics', bufnr)
        map('n', '[d', vim.diagnostic.goto_prev, 'LSP: Prev diagnostic', bufnr)
        map('n', ']d', vim.diagnostic.goto_next, 'LSP: Next diagnostic', bufnr)
        map('n', 'gl', vim.diagnostic.open_float, 'LSP: Line diagnostics', bufnr)
        -- Format via conform if available, else LSP
        map('n', '<leader>lf', function()
          local ok, conform = pcall(require, 'conform')
          if ok then conform.format({ async = false, lsp_fallback = true }) else vim.lsp.buf.format({ async = false }) end
        end, 'LSP: Format buffer', bufnr)

        -- Python: organize imports
        if client.name == 'pyright' then
          map('n', '<leader>lo', function()
            vim.lsp.buf.code_action({ apply = true, context = { only = { 'source.organizeImports' } } })
          end, 'LSP: Organize imports (Python)', bufnr)
        end
      end

      lspconfig.pyright.setup { capabilities = capabilities, on_attach = on_attach }
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
          },
        },
      }

      -- YAML LSP with SchemaStore schemas
      lspconfig.yamlls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          yaml = {
            schemaStore = { enable = false, url = "" },
            schemas = require('schemastore').yaml.schemas(),
            validate = true,
            keyOrdering = false,
          },
        },
      }
    end,
  },
}
