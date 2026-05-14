-- Provides Treesitter for improved syntax highlighting.

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    cmd = { "TSInstall", "TSInstallSync", "TSUpdate", "TSUpdateSync" },
    opts = {
      auto_install = true,
      ensure_installed = {
        "css",
        "html",
        "javascript",
        "markdown",
        "markdown_inline",
        "python",
        "typescript",
        "vue",
        "yaml",
      },
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local ok = pcall(vim.treesitter.query.get, lang, "highlights")
          if ok then
            return false
          end
          vim.g.ts_query_error_warned = vim.g.ts_query_error_warned or {}
          if not vim.g.ts_query_error_warned[lang] then
            vim.g.ts_query_error_warned[lang] = true
            vim.schedule(function()
              vim.notify(
                ("Treesitter %s highlights disabled due to an invalid query. Run :TSUpdate to refresh parsers."):format(lang),
                vim.log.levels.WARN
              )
            end)
          end
          return true
        end,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
