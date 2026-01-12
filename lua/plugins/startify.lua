-- Toggle this plugin via `lua/plugins/disabled.lua`.
return {
  {
    "mhinz/vim-startify",
    event = "VimEnter",
    config = function()
      vim.g.startify_change_to_dir = 0
      vim.g.startify_files_number = 10
      vim.g.startify_session_persistence = 1
      vim.g.startify_session_autoload = 1
      vim.g.startify_enable_special = 1

      vim.g.startify_custom_header = {
        "   _   __                 _          ",
        "  / | / /__  ____ _ _   __(_)___ ___  ",
        " /  |/ / _ \\/ __ `/| | / / / __ `__ \\ ",
        "/ /|  /  __/ /_/ / | |/ / / / / / / / ",
        "/_/ |_|\\___/\\__,_/  |___/_/_/ /_/ /_/  ",
        "",
        "  start small, ship often",
        "",
      }

      vim.g.startify_lists = {
        { type = "sessions", header = { "   Sessions" } },
        { type = "files", header = { "   Recent files" } },
        { type = "dir", header = { "   Current directory" } },
        { type = "bookmarks", header = { "   Bookmarks" } },
        { type = "commands", header = { "   Commands" } },
      }

      vim.g.startify_bookmarks = {
        { c = "~/.config/nvim/init.lua" },
        { p = "~/projects" },
        { t = "~/tmp" },
      }

      vim.g.startify_commands = {
        { u = { "Update plugins", "Lazy update" } },
        { s = { "Sync plugins", "Lazy sync" } },
        { l = { "Open lazy.nvim", "Lazy" } },
        { r = { "Reload config", "source $MYVIMRC" } },
      }
    end,
  },
}
