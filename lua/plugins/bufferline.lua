-- A nice-looking buffer/tab line with diagnostics and NvimTree offset

return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        numbers = "none",
        diagnostics = "nvim_lsp",
        separator_style = "thin",
        show_buffer_close_icons = false,
        show_close_icon = false,
        always_show_bufferline = true,
        offsets = {
          { filetype = "NvimTree", text = "Explorer", highlight = "Directory", separator = true },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Buffer navigation keymaps
      vim.keymap.set('n', '<S-l>', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Buffer: Next' })
      vim.keymap.set('n', '<S-h>', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Buffer: Prev' })
      vim.keymap.set('n', '<leader>bd', '<Cmd>bdelete<CR>', { desc = 'Buffer: Close' })
      vim.keymap.set('n', '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', { desc = 'Buffer: Pin' })
    end,
  },
}

