-- Defines custom keymaps for Neovim.

local function lazy_load(plugin)
  local ok, lazy = pcall(require, "lazy")
  if ok then
    lazy.load({ plugins = { plugin } })
  end
end

local function telescope_builtin(fn, opts)
  return function()
    lazy_load("telescope.nvim")
    local ok, builtin = pcall(require, "telescope.builtin")
    if not ok then
      vim.notify("telescope not available", vim.log.levels.WARN)
      return
    end
    builtin[fn](opts or {})
  end
end

local function neo_tree_toggle(opts)
  opts = opts or {}
  return function()
    lazy_load("neo-tree.nvim")
    local ok, command = pcall(require, "neo-tree.command")
    if not ok then
      vim.notify("neo-tree not available", vim.log.levels.WARN)
      return
    end

    local reveal_file = vim.api.nvim_buf_get_name(0)
    if reveal_file == "" then
      reveal_file = nil
    end

    command.execute(vim.tbl_deep_extend("force", {
      source = opts.source or "filesystem",
      toggle = true,
      position = opts.position or "float",
      reveal = true,
      reveal_file = reveal_file,
      dir = (vim.uv or vim.loop).cwd(),
      selector = true,
    }, opts.extra or {}))
  end
end

-- Search (Telescope)
vim.keymap.set('n', '<leader>ff', telescope_builtin('find_files', { hidden = true }), { desc = 'Search: Files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin('live_grep'), { desc = 'Search: Live grep' })
vim.keymap.set('n', '<leader>fb', telescope_builtin('buffers'), { desc = 'Search: Buffers' })
vim.keymap.set('n', '<leader>fr', telescope_builtin('oldfiles'), { desc = 'Search: Recent files' })
-- Explorer (Neo-tree)
vim.keymap.set('n', '<leader>e', neo_tree_toggle({ source = 'filesystem' }), { desc = 'Explorer: Files' })
vim.keymap.set('n', '<leader>eb', neo_tree_toggle({ source = 'buffers' }), { desc = 'Explorer: Buffers' })
vim.keymap.set('n', '<leader>eg', neo_tree_toggle({ source = 'git_status', extra = { position = 'float' } }), { desc = 'Explorer: Git status' })

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

-- Multi-cursor (vim-visual-multi)
vim.keymap.set('n', '<leader>mn', '<Plug>(VM-Find-Under)', { desc = 'Multi: Add next match' })
vim.keymap.set('n', '<leader>mN', '<Plug>(VM-Find-Subword-Under)', { desc = 'Multi: Add next subword' })
vim.keymap.set('n', '<leader>ma', '<Plug>(VM-Select-All)', { desc = 'Multi: Select all matches' })
vim.keymap.set('n', '<leader>mu', '<Plug>(VM-Add-Cursor-Up)', { desc = 'Multi: Add cursor up' })
vim.keymap.set('n', '<leader>md', '<Plug>(VM-Add-Cursor-Down)', { desc = 'Multi: Add cursor down' })
vim.keymap.set('n', '<leader>ms', '<Plug>(VM-Skip-Region)', { desc = 'Multi: Skip match' })
vim.keymap.set('n', '<leader>mr', '<Plug>(VM-Remove-Region)', { desc = 'Multi: Remove match' })
vim.keymap.set('n', '<leader>ml', '<Plug>(VM-Reselect-Last)', { desc = 'Multi: Reselect last' })

-- Surround (mini.surround)
vim.keymap.set({ 'n', 'v' }, '<leader>sa', function()
  require('mini.surround').add()
end, { desc = 'Surround: Add' })
vim.keymap.set('n', '<leader>sd', function()
  require('mini.surround').delete()
end, { desc = 'Surround: Delete' })
vim.keymap.set('n', '<leader>sr', function()
  require('mini.surround').replace()
end, { desc = 'Surround: Replace' })
vim.keymap.set('n', '<leader>sf', function()
  require('mini.surround').find()
end, { desc = 'Surround: Find' })
vim.keymap.set('n', '<leader>sF', function()
  require('mini.surround').find_left()
end, { desc = 'Surround: Find left' })
vim.keymap.set('n', '<leader>sh', function()
  require('mini.surround').highlight()
end, { desc = 'Surround: Highlight' })
vim.keymap.set('n', '<leader>sn', function()
  require('mini.surround').update_n_lines()
end, { desc = 'Surround: Update n lines' })
-- (Optional) If you still want a cycle key, you can repurpose this later
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

return {}
