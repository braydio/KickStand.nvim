-- Manages installed colorschemes and sets a default theme.

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  { "folke/tokyonight.nvim", lazy = true, priority = 1000 },
  { "rose-pine/neovim", name = "rose-pine" },
  { "rebelot/kanagawa.nvim" },
  { "EdenEast/nightfox.nvim" },
}
