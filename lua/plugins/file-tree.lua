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
    local command = require("neo-tree.command")

    neotree.setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      source_selector = false,
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
          visible = false,
          hide_dotfiles = true,
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
    })
<<<<<<< HEAD
=======

    local function current_file()
      local bufname = vim.api.nvim_buf_get_name(0)
      if bufname == "" then
        return nil
      end
      return bufname
    end

    local function toggle_filesystem(opts)
      opts = opts or {}
      command.execute(vim.tbl_deep_extend("force", {
        source = "filesystem",
        toggle = true,
        position = "left",
        reveal = opts.reveal or false,
        reveal_file = opts.reveal and current_file() or nil,
        dir = (vim.uv or vim.loop).cwd(),
      }, opts.extra or {}))
    end

    vim.keymap.set("n", "<leader>e", function()
      toggle_filesystem()
    end, { desc = "Explorer: Toggle file tree" })

    vim.keymap.set("n", "<leader>ef", function()
      toggle_filesystem({ reveal = true })
    end, { desc = "Explorer: Reveal current file" })

    vim.keymap.set("n", "<leader>eb", function()
      command.execute({ source = "buffers", toggle = true, position = "left" })
    end, { desc = "Explorer: Buffers" })

    vim.keymap.set("n", "<leader>eg", function()
      command.execute({ source = "git_status", toggle = true, position = "float" })
    end, { desc = "Explorer: Git status" })
>>>>>>> 92c24d2 (file-tree)
  end,
}
