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
vim.o.timeoutlen = 300

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

return {}
