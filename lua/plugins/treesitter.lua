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
      local function patch_python_except_star_query()
        local ok = pcall(vim.treesitter.query.get, "python", "highlights")
        if ok then
          return
        end

        local query_files = vim.api.nvim_get_runtime_file("queries/python/highlights.scm", true)
        local treesitter_query_file
        for _, file in ipairs(query_files) do
          if file:find("nvim%-treesitter", 1, false) then
            treesitter_query_file = file
            break
          end
        end
        if not treesitter_query_file then
          return
        end

        local lines = vim.fn.readfile(treesitter_query_file)
        local query = table.concat(lines, "\n")
        local patched = query:gsub('\n%s*"except%*"%s*', "\n")
        if patched == query then
          return
        end

        local patched_ok = pcall(vim.treesitter.query.set, "python", "highlights", patched)
        if not patched_ok then
          return
        end

        vim.schedule(function()
          vim.notify(
            "Treesitter python highlights query patched for parser compatibility (removed except*).",
            vim.log.levels.WARN
          )
        end)
      end

      patch_python_except_star_query()
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
