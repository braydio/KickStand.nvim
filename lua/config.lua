-- ~/.config/nvim/lua/config.lua

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Keymaps
vim.keymap.set("n", "<leader>e", ":Ex<CR>")
vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- Colorschemes
-- vim.cmd.colorscheme("catppuccin-mocha")   -- Change to any of the installed ones
-- vim.cmd.colorscheme("tokyonight-night")
-- vim.cmd.colorscheme("rose-pine")
-- vim.cmd.colorscheme("nightfox")
-- vim.cmd.colorscheme("kanagawa-wave")

