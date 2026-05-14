-- Defines custom keymaps for Neovim.

local function telescope_builtin(fn, opts)
  return function()
    local ok, builtin = pcall(require, "telescope.builtin")
    if not ok then
      vim.notify("telescope not available", vim.log.levels.WARN)
      return
    end
    builtin[fn](opts or {})
  end
end

-- Search (Telescope)
vim.keymap.set('n', '<leader>ff', telescope_builtin('find_files', { hidden = true }), { desc = 'Search: Files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin('live_grep'), { desc = 'Search: Live grep' })
vim.keymap.set('n', '<leader>fb', telescope_builtin('buffers'), { desc = 'Search: Buffers' })
vim.keymap.set('n', '<leader>fr', telescope_builtin('oldfiles'), { desc = 'Search: Recent files' })
vim.keymap.set('n', '<leader>FN', function()
  local path = vim.fn.input('New file: ', '', 'file')
  if path == '' then
    return
  end
  vim.cmd('edit ' .. vim.fn.fnameescape(path))
end, { desc = 'File: New' })

vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Write buffer' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
-- UI: Colorschemes
vim.keymap.set('n', '<leader>uc', '<cmd>Telescope colorscheme<CR>', { desc = 'Choose colorscheme' })
-- UI: Format
vim.keymap.set({ 'n', 'v' }, '<leader>uf', function()
  local ok, conform = pcall(require, 'conform')
  if ok then
    conform.format({ async = false, lsp_fallback = true })
  else
    vim.lsp.buf.format({ async = false })
  end
end, { desc = 'Format file' })
-- UI: Markdown
vim.keymap.set('n', '<leader>um', '<cmd>MarkdownPreviewToggle<CR>', { desc = 'Markdown: Browser preview' })
vim.keymap.set('n', '<leader>uM', function()
  if pcall(vim.cmd, 'Markview') then
    return
  end

  local ok, mv = pcall(require, 'markview')
  if ok and type(mv.toggle) == 'function' then
    mv.toggle()
    return
  end

  vim.notify('markview not available', vim.log.levels.WARN)
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

-- vim.keymap.set('n', '<leader>t', function() end, { desc = 'Cycle next colorscheme' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus left' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus down' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus up' })
-- Window resize shortcuts similar to LazyVim
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Calcurse calendar integrated with planner autocmd
-- vim.keymap.set('n','<leader>cL :split | terminal calcurse<CR>', { desc = 'Launch Calcurse in split terminal' })

return {}
