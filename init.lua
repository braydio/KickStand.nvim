-- ~/.config/nvim/init.lua

-- Set leader keys before anything else
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load configuration modules
require('config')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local repo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', repo, lazypath })
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup plugins
require('lazy').setup({
  spec = { { import = 'plugins' } },
  defaults = { lazy = true },
  install = { colorscheme = { 'catppuccin', 'tokyonight', 'rose-pine' } },
})
