-- Configures the statusline using lualine.

return {
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require('lualine').setup()
    end,
  },
}
