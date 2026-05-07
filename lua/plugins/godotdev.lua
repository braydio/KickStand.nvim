-- Godot development plugin with LSP, debugging, formatting, and docs
return {
  "Mathijs-Bakker/godotdev.nvim",
  ft = { "gd", "gdscript", "gdshader" },
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    editor_host = "127.0.0.1",      -- Godot editor host
    editor_port = 6005,               -- Godot LSP port
    debug_port = 6006,                -- Godot debugger port
    csharp = false,                    -- Set to true if using C# in Godot
    autostart_editor_server = false,    -- Don't auto-start (Godot manages this)
    formatter = "gdformat",           -- Use gdformat for formatting
    formatter_cmd = nil,               -- Custom formatter command (optional)
    
    -- Treesitter configuration
    treesitter = {
      auto_setup = true,               -- Auto-setup treesitter
      ensure_installed = { "gdscript" },
    },
    
    -- Godot docs configuration
    docs = {
      renderer = "float",             -- "float" | "buffer" | "browser"
      fallback_renderer = "browser",   -- Fallback if float fails
      missing_symbol_feedback = "message", -- "message" | "notify"
      version = "stable",             -- "stable" | "latest" | "4.x"
      language = "en",
      source_ref = "master",        -- Git ref for docs source
      timeout_ms = 10000,
    },
  },
  config = function(_, opts)
    require("godotdev").setup(opts)
  end,
}
