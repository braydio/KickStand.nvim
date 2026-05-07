-- ~/.config/nvim/init.lua

-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Load configuration
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
  install = { colorscheme = { 'catppuccin', 'tokyonight', 'rose-pine', 'nightfox', 'gruvbox', 'onedark' } },
  git = { url_format = 'git@github.com:%s.git' },
})

-- Planner Command (Move to proper directory asap)
vim.cmd [[
  function! SetDailyTemplate()
    let l:date = strftime("%A, %B %d, %Y")
    execute "normal! ggdG"
    call append(0, "# Daily Planner - " . l:date)
    call append(1, "")
    call append(2, "## Morning Goals & Priorities")
    call append(3, "- [ ] Example: Review emails")
    call append(4, "- [ ] Example: Set top 3 priorities")
    call append(5, "")
    call append(6, "## Schedule")
    call append(7, "08:00 - 09:00 :")
    call append(8, "09:00 - 10:00 :")
    call append(9, "10:00 - 11:00 :")
    call append(10, "…")
    call append(11, "")
    call append(12, "## Tasks")
    call append(13, "- [ ] Task 1")
    call append(14, "- [ ] Task 2")
    call append(15, "")
    call append(16, "## Evening Reflection & Notes")
    call append(17, "- What went well?")
    call append(18, "- What could be improved?")
    call append(19, "- Notes:")
    call append(20, "- One notable thing about today is...")
    call append(21, "- Reflections:")
    call append(22, "- One thing to reflect one about today is...")
  normal! G
  endfunction

  augroup DailyPlanner
    autocmd!
    autocmd BufNewFile ~/Documents/Journal/Planner/*.md call SetDailyTemplate()
  augroup END
]]

