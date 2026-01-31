# Repository Guidelines
 - Golden Rule of (Preventing) Documentation Drift:
    > Update the documentation for the repo whenever you change anything or find stale or otherwise incorrect documentation (including this file).

## Project Structure & Module Organization
- `init.lua` bootstraps `lazy.nvim`, sets leaders, and loads `lua/config`.
- `lua/init.lua` mirrors the top-level bootstrap; keep it in sync if you rely on `require("init")` elsewhere.
- `lua/config/` holds core settings (options, keymaps, init).
- `lua/plugins/` contains plugin specs and configuration modules, grouped by feature (lsp, telescope, treesitter, etc.).
- `lua/plugins/disabled.lua` is the single toggle list for disabling plugins without editing their configs.
- `lua/plugins/file-tree.lua` configures `neo-tree` (primary explorer); `lua/plugins/nvim-tree.lua` is present but disabled.
- `after/plugin/` contains post-load overrides (currently `tablemode.lua` patches Tableize to avoid E790 on undo).
- `lua/snippets/` stores custom snippets; `lazy-lock.json` pins plugin versions.
- `README.md` documents keymaps, themes, and common workflows.
- `.nvimlog` is a local log artifact; keep it out of version control.

## Build, Test, and Development Commands
- `nvim` to load the config locally.
- `:Lazy sync` to install/update plugins after changes.
- `:Lazy update` to refresh plugin versions.
- `:Mason` to verify external tools (LSP/formatters) are installed.

## Coding Style & Naming Conventions
- Lua files use two-space indentation; follow existing patterns per file.
- Keep plugin spec files under `lua/plugins/` and use descriptive filenames (e.g., `telescope.lua`).
- Prefer concise module names and keep plugin toggles in `lua/plugins/disabled.lua`.
- When adding a new plugin, add its repo string to the enable/disable list in `lua/plugins/disabled.lua` so it can be toggled easily later.
- If you add Treesitter parsers, update `lua/plugins/treesitter.lua` to keep `ensure_installed` comprehensive.

## Testing Guidelines
- No automated tests are configured.
- Manual checks: launch `nvim`, run `:Lazy sync`, and verify the relevant feature or keymap behaves as expected.

## Commit & Pull Request Guidelines
- No established Git history; use imperative commit messages (e.g., “Add Startify config”).
- PRs should include: summary of changes, why they’re needed, and how to validate (commands or steps).
- Call out any plugin additions/removals and updates to `lazy-lock.json`.

## Security & Configuration Tips
- Do not commit secrets (e.g., `OPENAI_API_KEY`); keep credentials in env vars.
- Note that `gp.nvim` can use external providers; confirm endpoints before sharing configs.
