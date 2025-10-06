-- Formatting setup using conform.nvim for general languages and formatter.nvim for Markdown

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
      notify_on_error = false,
      format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
      },
      formatters_by_ft = {
        yaml = { "yamlfmt", "prettierd", "prettier" },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },
  {
    "mhartington/formatter.nvim",
    ft = { "markdown", "markdown.mdx" },
    config = function()
      local formatter = require("formatter")
      local util = require("formatter.util")

      formatter.setup({
        logging = false,
        filetype = {
          markdown = {
            function()
              return {
                exe = "prettier",
                args = { "--stdin-filepath", util.escape_path(util.get_current_buffer_file_path()) },
                stdin = true,
              }
            end,
          },
          ["markdown.mdx"] = {
            function()
              return {
                exe = "prettier",
                args = { "--stdin-filepath", util.escape_path(util.get_current_buffer_file_path()) },
                stdin = true,
              }
            end,
          },
        },
      })

      local group = vim.api.nvim_create_augroup("MarkdownFormatter", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = group,
        pattern = { "*.md", "*.markdown", "*.mdx" },
        command = "silent! FormatWrite",
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "yamlfmt",
        "prettierd",
        "prettier",
      },
      run_on_start = true,
      start_delay = 0,
      auto_update = false,
    },
  },
}
