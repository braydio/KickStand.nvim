-- Provides Treesitter for improved syntax highlighting.

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    cmd = { "TSInstall", "TSInstallSync", "TSUpdate", "TSUpdateSync" },
    opts = {
      auto_install = true,
      ensure_installed = { "markdown", "markdown_inline", "python", "yaml" },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      local ok, configs = pcall(require, "nvim-treesitter.configs")
      if ok then
        configs.setup(opts)
        return
      end

      local treesitter = require("nvim-treesitter")
      treesitter.setup({
        install_dir = opts.install_dir,
      })

      treesitter.install(opts.ensure_installed)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("config_treesitter", { clear = true }),
        callback = function()
          pcall(vim.treesitter.start)

          if opts.indent and opts.indent.enable then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
