-- Formatting setup using conform.nvim.

return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      notify_on_error = false,
      format_on_save = {
        lsp_fallback = false,
        timeout_ms = 500,
      },
      formatters_by_ft = {
        bash = { "shfmt" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        markdown = { "prettierd", "prettier" },
        ["markdown.mdx"] = { "prettierd", "prettier" },
        python = { "isort", "black" },
        sh = { "shfmt" },
        toml = { "taplo" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        yaml = { "yamlfmt", "prettierd", "prettier" },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "black",
        "isort",
        "prettier",
        "prettierd",
        "ruff",
        "shfmt",
        "taplo",
        "yamlfmt",
      },
      run_on_start = true,
      start_delay = 0,
      auto_update = false,
    },
  },
}
