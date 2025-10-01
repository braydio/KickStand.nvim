-- Shows a contextual popup with available keymaps.

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- Register top-level groups for nicer popups
      wk.add({
        { "<leader>u", group = "UI" },
        { "<leader>g", group = "GP" },
        { "<leader>e", group = "Explorer" },
        { "<leader>l", group = "LSP" },
        { "<leader>,", group = "Buffers" },
      })
    end,
  },
}
