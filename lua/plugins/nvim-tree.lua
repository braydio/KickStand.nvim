-- lua/plugins/nvim-tree.lua
return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup {
        hijack_netrw = true,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = { enable = true, update_root = true },
        diagnostics = { enable = true, show_on_dirs = true },
        git = { enable = true, ignore = false, show_on_dirs = true },
        view = { width = 34, side = "left", preserve_window_proportions = true },
        renderer = {
          highlight_git = true,
          highlight_opened_files = "icon",
          root_folder_label = true,
          indent_markers = { enable = true },
          icons = { show = { file = true, folder = true, folder_arrow = true, git = true } },
          special_files = { "README.md", "readme.md", "pyproject.toml", "package.json" },
        },
        filters = { dotfiles = false, custom = { "^%.git$" } },
      }

      -- File tree keymaps
      vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>', { desc = 'Explorer: Toggle' })
      vim.keymap.set('n', '<leader>ef', '<cmd>NvimTreeFindFile<CR>', { desc = 'Explorer: Reveal current file' })
      vim.keymap.set('n', '<leader>er', '<cmd>NvimTreeRefresh<CR>', { desc = 'Explorer: Refresh' })
      vim.keymap.set('n', '<leader>ec', '<cmd>NvimTreeCollapse<CR>', { desc = 'Explorer: Collapse all' })
    end,
  }
}
