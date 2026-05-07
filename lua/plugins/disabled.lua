-- Central place to toggle plugins without touching their config files.
-- Add plugin repo strings below (e.g. "mhinz/vim-startify") to disable them.
local disabled = {
  "goolord/alpha-nvim",
  "mhinz/vim-startify",
  -- "Exafunction/codeium.nvim",
  -- "mg979/vim-visual-multi",
  -- "nvim-neotest/nvim-nio",
  -- "nvimdev/dashboard-nvim",
}

local specs = {}
for _, name in ipairs(disabled) do
  specs[#specs + 1] = { name, enabled = false }
end

return specs
