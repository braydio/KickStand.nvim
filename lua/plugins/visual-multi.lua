-- Adds multi-cursor editing with vim-visual-multi.

return {
  {
    "mg979/vim-visual-multi",
    keys = {
      { "<leader>mn", "<Plug>(VM-Find-Under)", desc = "Multi: Find under / add next", remap = true, mode = "n" },
      { "<leader>mn", "<Plug>(VM-Find-Subword-Under)", desc = "Multi: Find selection (subword)", remap = true, mode = "x" },

      { "<leader>ma", "<Plug>(VM-Select-All)", desc = "Multi: Select all matches", remap = true, mode = "n" },
      { "<leader>ma", "<Plug>(VM-Visual-All)", desc = "Multi: Select all (from selection)", remap = true, mode = "x" },

      { "<leader>md", "<Plug>(VM-Select-Cursor-Down)", desc = "Multi: Cursor down", remap = true, mode = "n" },
      { "<leader>mu", "<Plug>(VM-Select-Cursor-Up)", desc = "Multi: Cursor up", remap = true, mode = "n" },

      { "<leader>ms", "<Plug>(VM-Skip-Region)", desc = "Multi: Skip region", remap = true, mode = "n" },
      { "<leader>mr", "<Plug>(VM-Remove-Region)", desc = "Multi: Remove region", remap = true, mode = "n" },
      { "<leader>ml", "<Plug>(VM-Reselect-Last)", desc = "Multi: Reselect last", remap = true, mode = "n" },
    },
  },
}
