local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Plugin list
require("lazy").setup({
  -- Colorschemes
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  { "rose-pine/neovim",
      name = "rose-pine",
      config = function()
        vim.cmd("colorscheme rose-pine")
      end
    },
  { "EdenEast/nightfox.nvim" },
  { "rebelot/kanagawa.nvim" },

  -- Core tools
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-lualine/lualine.nvim" },
  }, {
  
  -- Lazy.nvim options
  install = {
    colorscheme = { "catppuccin", "tokyonight", "rose-pine" },
  },
  defaults = { lazy = true },
  })

-- Load persisted colorscheme if available
local themefile = vim.fn.stdpath("config") .. "/colorscheme.txt"
local default_theme = "catppuccin"

-- Try to read saved theme
local ok, saved_theme = pcall(function()
  local f = io.open(themefile, "r")
  if not f then return nil end
  local theme = f:read("*l")
  f:close()
  return theme
end)

-- Fallback if nothing saved or loading fails
local theme = (ok and saved_theme and #saved_theme > 0) and saved_theme or default_theme

-- Try to load the theme
local success, err = pcall(vim.cmd.colorscheme, theme)
if not success then
  vim.notify("Failed to load colorscheme '" .. theme .. "': " .. err, vim.log.levels.WARN)
end

