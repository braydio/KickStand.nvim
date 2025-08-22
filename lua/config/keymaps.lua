-- Defines custom keymaps for Neovim.

local map = vim.keymap.set

map('n', '<leader>w', '<cmd>w<CR>', { desc = 'Write buffer' })
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus left' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus right' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus down' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus up' })

return {}
