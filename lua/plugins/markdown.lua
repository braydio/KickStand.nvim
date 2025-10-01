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
}
