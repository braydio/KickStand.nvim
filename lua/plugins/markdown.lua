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
    cmd = { "Outline" },
    ft = { "markdown" },
    opts = {
      outline_window = {
        position = "right",
        width = 35,
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
