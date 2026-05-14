-- Central place to toggle plugins without touching their config files.
-- Add plugin repo strings below (e.g. "Exafunction/codeium.nvim") to disable them.
local disabled = {
  -- "Exafunction/codeium.nvim",
  -- "lewis6991/gitsigns.nvim",
  -- "mg979/vim-visual-multi",
  -- "nvimdev/dashboard-nvim",
}

local specs = {}
for _, name in ipairs(disabled) do
  specs[#specs + 1] = { name, enabled = false }
end

return specs
