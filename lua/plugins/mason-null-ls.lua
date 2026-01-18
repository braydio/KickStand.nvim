-- null-ls integrated with mason-nvim
return {
  "jay-babu/mason-null-ls.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim",  -- (formerly null-ls)
  },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed = { "black", "isort", "prettier" }, -- tools you want
      automatic_installation = true,  -- auto install missing ones
      handlers = {}, -- default handler auto-registers them with none-ls
    })
  end,
}
