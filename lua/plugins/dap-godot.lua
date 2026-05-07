-- DAP debugging support for Godot/GDScript
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
  },
  ft = { "gd", "gdscript", "gdshader" },
  config = function()
    local dap = require("dap")
    local dap_ui = require("dapui")
    local dap_virtual_text = require("nvim-dap-virtual-text")
    
    -- Setup DAP UI
    dap_ui.setup({
      icons = { expanded = "▾", collapsed = "▸" },
      mappings = {
        -- Open repl = '<F8>',
        open_repl = '<F8>',
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.30 },
            { id = "breakpoints", size = 0.20 },
            { id = "stacks", size = 0.20 },
            { id = "watches", size = 0.30 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "repl", size = 0.60 },
            { id = "console", size = 0.40 },
          },
          size = 0.25,
          position = "bottom",
        },
      },
    })
    
    -- Setup virtual text
    dap_virtual_text.setup({
      enabled = true,
      all_frames = true,
    })
    
    -- Godot DAP configuration
    dap.adapters.godot = {
      type = "server",
      host = "127.0.0.1",
      port = 6006,  -- Godot debug port (default)
    }
    
    dap.configurations.gd = {
      {
        type = "godot",
        request = "launch",
        name = "Launch Godot Scene",
        project = vim.fn.getcwd(),
        scene = nil,  -- Will prompt or use last scene
      },
      {
        type = "godot",
        request = "attach",
        name = "Attach to Godot",
        project = vim.fn.getcwd(),
      },
    }
    
    -- Keymaps
    local keymap = vim.keymap.set
    keymap("n", "<F5>", function() dap.continue() end, { desc = "DAP: Continue" })
    keymap("n", "<F10>", function() dap.step_over() end, { desc = "DAP: Step Over" })
    keymap("n", "<F11>", function() dap.step_into() end, { desc = "DAP: Step Into" })
    keymap("n", "<F12>", function() dap.step_out() end, { desc = "DAP: Step Out" })
    keymap("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "DAP: Toggle Breakpoint" })
    keymap("n", "<leader>dB", function() dap.set_breakpoint() end, { desc = "DAP: Set Breakpoint" })
    keymap("n", "<leader>dr", function() dap.repl.open() end, { desc = "DAP: Open REPL" })
    keymap("n", "<leader>du", function() dap_ui.toggle() end, { desc = "DAP: Toggle UI" })
  end,
}
