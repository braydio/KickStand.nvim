-- Defines custom keymaps for Neovim.

--local map = vim.keymap.set

vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Write buffer' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- UI: Colorschemes
vim.keymap.set('n', '<leader>uc', '<cmd>Telescope colorscheme<CR>', { desc = 'Choose colorscheme' })
-- UI: Format
vim.keymap.set({ 'n', 'v' }, '<leader>uf', function()
  require('conform').format({ async = false, lsp_fallback = true })
end, { desc = 'Format file' })
-- UI: Markdown
vim.keymap.set('n', '<leader>um', '<cmd>MarkdownPreviewToggle<CR>', { desc = 'Markdown: Browser preview' })
vim.keymap.set('n', '<leader>uM', function()
  local ok, rm = pcall(require, 'render-markdown')
  if ok then rm.toggle() else vim.notify('render-markdown not available', vim.log.levels.WARN) end
end, { desc = 'Markdown: Toggle in-buffer render' })
-- Buffers/Tabs: quick buffer picker
vim.keymap.set('n', '<leader>,', function()
  local ok, builtin = pcall(require, 'telescope.builtin')
  if ok then
    builtin.buffers()
  else
    vim.cmd('ls')
  end
end, { desc = 'Buffers: List/switch' })
-- (Optional) If you still want a cycle key, you can repurpose this later
-- vim.keymap.set('n', '<leader>t', function() end, { desc = 'Cycle next colorscheme' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus down' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus up' })

return {}
