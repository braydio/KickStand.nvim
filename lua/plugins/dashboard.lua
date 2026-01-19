-- Startup dashboard when launching with no file arguments

return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      local day_name = os.date("%A")
      local date_line = os.date("%B %d, %Y")

      dashboard.section.header.val = {
        "",
        "   _   __                         _          ",
        "  / | / /__  ____  ____ ___  ___  (_)___ ___  ",
        " /  |/ / _ \\/ __ \\/ __ `__ \\/ _ \\/ / __ `__ \\ ",
        "/ /|  /  __/ /_/ / / / / / /  __/ / / / / / / ",
        "/_/ |_|\\___/\\____/_/ /_/ /_/\\___/_/_/ /_/ /_/  ",
        "",
        "  " .. day_name .. " energy",
        "  " .. date_line,
        "",
      }

      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
        dashboard.button("c", "  Config", ":edit ~/.config/nvim/init.lua<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      dashboard.section.footer.val = function()
        return "Have a productive session!"
      end
      dashboard.section.header.opts.hl = "Type"
      dashboard.section.footer.opts.hl = "Comment"

      dashboard.config.opts.noautocmd = true
      alpha.setup(dashboard.config)
    end,
  },
}
