-- Sets up nvim-cmp for autocompletion.

return {
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      local luasnip = require('luasnip')
      luasnip.setup({
        history = true,
        delete_check_events = 'TextChanged',
        region_check_events = 'InsertEnter',
      })

      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_lua').lazy_load({ paths = vim.fn.stdpath('config') .. '/lua/snippets' })
    end,
  },
  {
    'Exafunction/codeium.nvim',
    event = 'InsertEnter',
    config = function()
      local ok, codeium = pcall(require, 'codeium')
      if not ok then
        return
      end

      codeium.setup({})

      vim.keymap.set('i', '<C-g>', function()
        return codeium.accept()
      end, { expr = true, desc = 'Codeium: Accept suggestion' })

      vim.keymap.set('i', '<C-;>', function()
        return codeium.complete()
      end, { expr = true, desc = 'Codeium: Trigger suggestion' })

      vim.keymap.set('i', '<C-c>', function()
        return codeium.dismiss()
      end, { expr = true, desc = 'Codeium: Dismiss suggestion' })
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping(function(fallback)
            cmp.abort()
            fallback()
          end, { 'i', 's' }),
          ['<C-l>'] = cmp.mapping.confirm({ select = true }),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    end,
  },
}
