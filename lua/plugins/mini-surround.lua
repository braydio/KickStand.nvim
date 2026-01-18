-- Surround motions for adding/changing/removing delimiters.

return {
  {
    "echasnovski/mini.surround",
    keys = {
      { "sa", mode = { "n", "x" } },
      { "sd", mode = "n" },
      { "sf", mode = "n" },
      { "sF", mode = "n" },
      { "sh", mode = "n" },
      { "sr", mode = "n" },
      { "sn", mode = "n" },
    },
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "sa",
          delete = "sd",
          find = "sf",
          find_left = "sF",
          highlight = "sh",
          replace = "sr",
          update_n_lines = "sn",
        },
      })
    end,
  },
}
