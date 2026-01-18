-- none-ls.nvim LSP server for mason, formatting/linting etc.
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "williamboman/mason.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.prettier,
      },
    })
  end,
}
