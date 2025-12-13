-- Adds telescope fuzzy finding.

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    opts = {
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        layout_strategy = "flex",
        layout_config = {
          horizontal = { preview_width = 0.55 },
          vertical = { preview_height = 0.45 },
          width = 0.9,
          height = 0.85,
        },
      },
      pickers = {
        find_files = { hidden = true },
        live_grep = {
          additional_args = function()
            return { "--hidden", "--glob", "!.git/*" }
          end,
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      pcall(telescope.load_extension, "fzf")
    end,
  },
}
