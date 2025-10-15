-- Markdown visual rendering and browser preview

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {
      heading = { enabled = true },
      code = { enabled = true },
      dash = { enabled = true },
      bullet = { enabled = true },
      quote = { enabled = true },
      checkbox = { enabled = true },
    },
  },
  {
    "preservim/vim-markdown",
    ft = { "markdown" },
    config = function()
      vim.g.vim_markdown_folding_disabled = 0
      vim.g.vim_markdown_folding_level = 3
      vim.g.vim_markdown_conceal = 0
      vim.g.vim_markdown_new_list_item_indent = 2
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    config = function()
      -- Restrict to markdown filetype and enable lazy command loading
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 1
      vim.g.mkdp_echo_preview_url = 1
      vim.g.mkdp_page_title = "${name}"
    end,
  },
  {
    "hedyhli/outline.nvim",
    cmd = {
      "Outline",
      "OutlineOpen",
      "OutlineClose",
      "OutlineFocus",
      "OutlineFocusOutline",
      "OutlineFocusCode",
      "OutlineFollow",
      "OutlineRefresh",
    },
    keys = {
      {
        "<leader>so",
        function()
          require('outline').toggle_outline({ focus_outline = false })
        end,
        desc = "Outline: Toggle sidebar",
      },
      {
        "<leader>sf",
        function()
          require('outline').focus_toggle()
        end,
        desc = "Outline: Toggle focus",
      },
      {
        "<leader>sr",
        function()
          require('outline').refresh_outline()
        end,
        desc = "Outline: Refresh symbols",
      },
      {
        "<leader>ss",
        function()
          require('outline').follow_cursor({ focus_outline = false })
        end,
        desc = "Outline: Sync with cursor",
      },
    },
    opts = {
      outline_window = {
        position = "right",
        width = 35,
        relative_width = false,
        focus_on_open = false,
        auto_close = false,
        no_provider_message = "Outline: no symbols (is LSP running?)",
      },
      outline_items = {
        show_symbol_details = true,
        auto_set_cursor = true,
        highlight_hovered_item = true,
        auto_update_events = {
          follow = { "CursorMoved", "CursorHold" },
          items = { "BufWritePost", "BufEnter" },
        },
      },
      providers = {
        priority = { "lsp", "markdown", "man", "norg" },
        lsp = {
          blacklist_clients = {},
        },
        markdown = {
          filetypes = { "markdown" },
        },
      },
    },
    config = function(_, opts)
      require('outline').setup(opts)
    end,
  },
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    init = function()
      vim.g.table_mode_corner = "|"
      vim.g.table_mode_always_active = 0
    end,
  },
}
