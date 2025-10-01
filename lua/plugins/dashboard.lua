-- Startup dashboard when launching with no file arguments

return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "",
        "    Welcome to Neovim",
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

      dashboard.config.opts.noautocmd = true
      alpha.setup(dashboard.config)
    end,
  },
}

