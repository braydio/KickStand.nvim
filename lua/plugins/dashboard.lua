return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local dashboard = require("dashboard")
      dashboard.setup({
        theme = "hyper",
        config = {
          week_header = {
            enable = true,
          },
          shortcut = {
            { icon = " ", desc = "New file", group = "Label", action = "ene | startinsert", key = "e" },
            { icon = " ", desc = "Find file", group = "Label", action = "Telescope find_files", key = "f" },
            { icon = " ", desc = "Recent", group = "Label", action = "Telescope oldfiles", key = "r" },
            {
              icon = " ",
              desc = "Config",
              group = "Label",
              action = "edit ~/.config/nvim/init.lua",
              key = "c",
            },
            { icon = " ", desc = "Quit", group = "Label", action = "qa", key = "q" },
          },
          project = { enable = true, limit = 8 },
          mru = { limit = 10 },
          footer = { "Have a productive session!" },
        },
      })
    end,
  },
}
