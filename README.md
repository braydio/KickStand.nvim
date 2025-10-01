Neovim config overview

- Config lives in `lua/config`; plugins in `lua/plugins`, managed by `lazy.nvim`.
- Core includes Telescope, Treesitter, LSP, completion, formatting, themes, dashboard, which-key, and gp.nvim.

Themes and UI
- Colorschemes installed: Catppuccin (default), TokyoNight, Rose Pine, Kanagawa, Nightfox, Gruvbox, OneDark.
- Keymaps:
  - `<leader>uc` — open colorscheme picker (`:Telescope colorscheme`).
  - which-key shows contextual key hints for `<leader>` groups (e.g., `u` for UI, `g` for GP).
- Dashboard: Alpha shows a start screen on launch (no files) with buttons for New, Find, Recent, Config, Quit.

YAML support
- Treesitter: ensures `yaml` parser for syntax and indentation.
- LSP: `yaml-language-server` via lspconfig + SchemaStore for automatic schema detection and validation.
- Formatting: `conform.nvim` with `yamlfmt` (preferred) → `prettierd` → `prettier` fallback.
- Keymap: `<leader>uf` — format current buffer. YAML formats on save when tools are available.

gp.nvim (AI helpers)
- Providers: OpenAI (set `OPENAI_API_KEY`) and an example Ollama endpoint (edit or disable in `lua/plugins/gp.lua`).
- Start chat: `<leader>gn`.
- Next agent: `<leader>ga`.
- Visual selections (select code first):
  - `<leader>gr` — review code
  - `<leader>gf` — refactor code
  - `<leader>ge` — explain code
  - `<leader>gc` — add comments
  - `<leader>gm` — format as Markdown
  - `<leader>gt` — add type annotations
  - `<leader>gd` — add docstring
  - `<leader>gT` — generate unit tests
  - `<leader>gM` — craft commit message

Getting started
- Run `:Lazy sync` after cloning or updating config to install plugins.
- Check tooling with `:Mason` (should list `yamlls`, `yamlfmt`, `prettierd`).
- Set your OpenAI key in the environment: e.g., `export OPENAI_API_KEY=...`.

Notes
- Colorscheme defaults to Catppuccin; switch anytime with `<leader>uc`.
- gp.nvim logs to `~/.config/nvim/lazy_log.log`. A proxy is configured in `gp.lua` (disable or change if not needed).

## Keymap Cheat Sheet

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>w` | Normal | Write buffer |
| `<Esc>` | Normal | Clear search highlight |
| `<leader>ff` | Normal | Telescope: Find files |
| `<leader>fg` | Normal | Telescope: Live grep |
| `<leader>uc` | Normal | Colorscheme picker (Telescope) |
| `<leader>uf` | Normal/Visual | Format buffer/selection (conform) |
| `<leader>um` | Normal | Markdown: Browser preview toggle |
| `<leader>uM` | Normal | Markdown: In-buffer render toggle |
| `<leader>,` | Normal | Buffers: List/switch (Telescope) |
| `<leader>e` | Normal | Explorer: Toggle file tree |
| `<leader>ef` | Normal | Explorer: Reveal current file |
| `<leader>er` | Normal | Explorer: Refresh tree |
| `<leader>ec` | Normal | Explorer: Collapse all |
| `<leader>gn` | Normal | gp.nvim: New chat |
| `<leader>ga` | Normal | gp.nvim: Next agent |
| `<leader>gr` | Visual | gp.nvim: Review code (rewrite) |
| `<leader>gf` | Visual | gp.nvim: Refactor code (rewrite) |
| `<leader>ge` | Visual | gp.nvim: Explain code (rewrite) |
| `<leader>gc` | Visual | gp.nvim: Add comments (rewrite) |
| `<leader>gm` | Visual | gp.nvim: Markdown format (rewrite) |
| `<leader>gt` | Visual | gp.nvim: Add type annotations (rewrite) |
| `<leader>gd` | Visual | gp.nvim: Add docstring (rewrite) |
| `<leader>gT` | Visual | gp.nvim: Generate unit tests (rewrite) |
| `<leader>gM` | Visual | gp.nvim: Commit message from selection (rewrite) |
| `<S-h>` / `<S-l>` | Normal | Buffer: Prev / Next (bufferline) |
| `<leader>bd` | Normal | Buffer: Close (delete) |
| `<leader>bp` | Normal | Buffer: Pin |
| `gd` / `gD` / `gi` | Normal | LSP: Definition / Declaration / Implementation |
| `gr` | Normal | LSP: References (Telescope if available) |
| `K` | Normal | LSP: Hover |
| `[d` / `]d` | Normal | LSP: Prev/Next diagnostic |
| `gl` | Normal | LSP: Line diagnostics float |
| `<leader>lr` | Normal | LSP: Rename symbol |
| `<leader>la` | Normal | LSP: Code action |
| `<leader>ld` | Normal | LSP: Diagnostics (Telescope/loclist) |
| `<leader>lf` | Normal | LSP: Format (conform/LSP) |
| `<leader>lo` | Normal | LSP: Organize imports (Python) |
| `<C-h> / <C-j> / <C-k> / <C-l>` | Normal | Move window focus left/down/up/right |
| `<Esc><Esc>` | Terminal | Exit terminal mode to Normal |
