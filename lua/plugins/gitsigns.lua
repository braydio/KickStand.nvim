-- Git signs, hunk actions, blame, and lightweight diffs.

return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 600,
        ignore_whitespace = false,
      },
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, "Git: Next hunk")

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, "Git: Previous hunk")

        map("n", "<leader>hs", gitsigns.stage_hunk, "Git: Stage hunk")
        map("n", "<leader>hr", gitsigns.reset_hunk, "Git: Reset hunk")
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Git: Stage selection")
        map("v", "<leader>hr", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Git: Reset selection")

        map("n", "<leader>hS", gitsigns.stage_buffer, "Git: Stage buffer")
        map("n", "<leader>hR", gitsigns.reset_buffer, "Git: Reset buffer")
        map("n", "<leader>hp", gitsigns.preview_hunk, "Git: Preview hunk")
        map("n", "<leader>hi", gitsigns.preview_hunk_inline, "Git: Preview inline")
        map("n", "<leader>hb", function()
          gitsigns.blame_line({ full = true })
        end, "Git: Blame line")
        map("n", "<leader>hd", gitsigns.diffthis, "Git: Diff buffer")
        map("n", "<leader>hD", function()
          gitsigns.diffthis("~")
        end, "Git: Diff buffer against HEAD~")
        map("n", "<leader>hQ", function()
          gitsigns.setqflist("all")
        end, "Git: Hunks to quickfix")
        map("n", "<leader>hq", gitsigns.setqflist, "Git: Buffer hunks to quickfix")

        map("n", "<leader>hB", gitsigns.toggle_current_line_blame, "Git: Toggle line blame")
        map("n", "<leader>hw", gitsigns.toggle_word_diff, "Git: Toggle word diff")
        map({ "o", "x" }, "ih", gitsigns.select_hunk, "Git: Select hunk")
      end,
    },
  },
}
