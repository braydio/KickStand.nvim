-- Sets Neovim options and preferences.

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 1000

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

vim.o.list = true
vim.opt.listchars = { tab = ">>", trail = ".", nbsp = "_" }
vim.o.inccommand = "split"

vim.g.have_nerd_font = false

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-hightlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Colorscheme cycle
local colorschemes = { 'catppuccin', 'tokyonight', 'rose-pine' }
vim.g.current_colorscheme_index = 1
function ToggleColorscheme()
  vim.g.current_colorscheme_index = vim.g.current_colorscheme_index % #colorschemes + 1
  local scheme = colorschemes[vim.g.current_colorscheme_index]
  vim.cmd('colorscheme ' .. scheme)
  print('Colorscheme set to ' .. scheme)
end

return {}
