return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
    "MunifTanjim/nui.nvim",
  },
  config = function()
    local neotree = require("neo-tree")
    local manager = require("neo-tree.sources.manager")

    neotree.setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      source_selector = {
        winbar = true,
        statusline = false,
        content_layout = "center",
        tabs_layout = "equal",
        show_scrolled_off_parent_node = true,
        sources = {
          { source = "filesystem", display_name = "󰉓 Files" },
          { source = "buffers", display_name = "󰈙 Buffers" },
          { source = "git_status", display_name = "󰊢 Git" },
        },
      },
      default_component_configs = {
        container = { enable_character_fade = true },
        indent = {
          with_markers = true,
          indent_size = 2,
          padding = 1,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰜌",
          default = "󰈚",
        },
        modified = { symbol = "" },
        git_status = {
          symbols = {
            added = "",
            modified = "",
            deleted = "",
            renamed = "",
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },
      window = {
        position = "left",
        width = 32,
        popup = {
          size = {
            height = "85%",
            width = "60%",
          },
          position = "50%",
          title = function(state)
            local path = state.path or (vim.uv or vim.loop).cwd()
            return "  " .. vim.fn.fnamemodify(path, ":~")
          end,
        },
        mappings = {
          ["<cr>"] = "open",
          ["o"] = "open",
          ["l"] = "focus_preview",
          ["h"] = "close_node",
          ["<esc>"] = "close_window",
          ["P"] = {
            "toggle_preview",
            config = {
              use_float = true,
            },
          },
          ["S"] = "open_split",
          ["s"] = "open_vsplit",
          ["t"] = "open_tabnew",
          ["<C-r>"] = "refresh",
          ["yy"] = "copy",
          ["dd"] = "delete",
          ["R"] = "rename",
          ["?"] = "show_help",
        },
      },
      filesystem = {
        bind_to_cwd = false,
        hijack_netrw_behavior = "open_current",
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        use_libuv_file_watcher = true,
        group_empty_dirs = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = { "node_modules" },
          never_show = { ".DS_Store", "thumbs.db" },
        },
        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["."] = "set_root",
            ["H"] = "toggle_hidden",
            ["F"] = "fuzzy_finder",
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
          },
        },
      },
      buffers = {
        follow_current_file = true,
        group_empty_dirs = true,
        show_unloaded = true,
      },
      git_status = {
        window = {
          position = "float",
        },
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            local state = manager.get_state("filesystem")
            if state and state.current_position == "float" then
              require("neo-tree.command").execute({ action = "close" })
            end
          end,
        },
      },
    })
  end,
}
