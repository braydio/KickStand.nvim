-- Provides Treesitter for improved syntax highlighting.

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    cmd = { "TSInstall", "TSInstallSync", "TSUpdate", "TSUpdateSync" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      auto_install = true,
      ensure_installed = { "markdown", "markdown_inline", "python", "yaml" },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
