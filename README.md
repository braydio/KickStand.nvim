Neovim config overview

- Config lives in `lua/config`; plugins in `lua/plugins`, managed by `lazy.nvim`.
- Core includes Telescope (with ripgrep live-grep and fzf native sorter), Neo-tree explorer, Treesitter, LSP, completion, Conform formatting, themes, dashboard, Git hunk actions, which-key, gp.nvim, and Godot debugging support.

Plugin overview
- Main stack: Telescope, Neo-tree, Treesitter, LSP via mason.nvim + nvim-lspconfig, completion via nvim-cmp + LuaSnip, formatting via conform.nvim, and Git buffer integration via gitsigns.nvim.
- Not-quite-standard additions: gp.nvim (AI chat/rewrite), codeium.nvim (inline AI), markdown suite (markview, markdown-preview, vim-markdown, table-mode), outline.nvim, vim-visual-multi.
- Godot: godotdev.nvim plus nvim-dap, nvim-dap-ui, nvim-nio, and nvim-dap-virtual-text load for GDScript/Godot buffers.
- Startup screen: dashboard-nvim is enabled; optional plugin toggles live in `lua/plugins/disabled.lua`.
- Themes: Catppuccin default plus TokyoNight, Rose Pine, Kanagawa, Nightfox, Gruvbox, OneDark.

Other plugins
- lualine.nvim, bufferline.nvim, gitsigns.nvim, which-key.nvim, mini.surround, nvim-web-devicons.

Themes and UI
- Colorschemes installed: Catppuccin (default), TokyoNight, Rose Pine, Kanagawa, Nightfox, Gruvbox, OneDark.
- Keymaps:
  - `<leader>ff` / `<leader>fg` — Telescope file finder / live grep (hidden files included).
  - `<leader>e` / `<leader>ef` / `<leader>eb` / `<leader>eg` — Neo-tree files / reveal current file / buffers / git status.
  - `<leader>uc` — open colorscheme picker (`:Telescope colorscheme`).
  - which-key shows contextual key hints for `<leader>` groups (e.g., `u` for UI, `g` for GP).
- Dashboard: dashboard-nvim shows a start screen on launch (no files) with shortcuts, projects, and recent files.

YAML support
- Treesitter: ensures `yaml` parser for syntax and indentation.
- LSP: `yaml-language-server` via lspconfig + SchemaStore for automatic schema detection and validation.
- Formatting: `conform.nvim` with `yamlfmt` (preferred) -> `prettierd` -> `prettier` fallback.
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

Codeium (inline AI)
- Plugin: `Exafunction/codeium.nvim`.
- Authenticate with `:Codeium Auth` if prompted.
- Insert mode:
  - `<C-g>` — accept inline suggestion
  - `<C-;>` — trigger suggestion
  - `<C-c>` — dismiss suggestion

Git hunks
- Plugin: `lewis6991/gitsigns.nvim`.
- Navigate hunks with `]c` and `[c`.
- Common actions:
  - `<leader>hp` — preview hunk
  - `<leader>hs` / `<leader>hr` — stage/reset hunk or visual selection
  - `<leader>hb` — blame current line
  - `<leader>hB` — toggle inline blame
  - `<leader>hw` — toggle word diff

Getting started
- Run `:Lazy sync` after cloning or updating config to install plugins.
- Check tooling with `:Mason` (should list `yamlls`, `yamlfmt`, `prettierd`).
- Set your OpenAI key in the environment: e.g., `export OPENAI_API_KEY=...`.

Notes
- Colorscheme defaults to Catppuccin; switch anytime with `<leader>uc`.
- gp.nvim logs to Neovim state as `gp.nvim.log`. A proxy is configured in `gp.lua` (disable or change if not needed).
- mini.surround: use the default mappings (`sa`, `sd`, `sr`, `sf`, etc.). Leader-wrapped Lua calls were removed because they can desync the “highlighted” region.
- vim-visual-multi: keymaps create selections/cursors in Normal/Visual mode; once you see multiple selections, press `i`/`a`/`c` to edit across all cursors, and `<Esc>` to exit.
- If Treesitter reports an invalid Python query such as `except*`, check for stale duplicate parsers in `~/.local/share/nvim/site/parser/`; nvim-treesitter parsers should take precedence.

## Keymap Cheat Sheet

| Key | Mode | Action |
| --- | --- | --- |
| `<leader>w` | Normal | Write buffer |
| `<Esc>` | Normal | Clear search highlight |
| `<leader>ff` | Normal | Telescope: Find files |
| `<leader>fg` | Normal | Telescope: Live grep |
| `<leader>fb` | Normal | Telescope: Buffers |
| `<leader>fr` | Normal | Telescope: Recent files |
| `<leader>FN` | Normal | File: New |
| `<leader>uc` | Normal | Colorscheme picker (Telescope) |
| `<leader>uf` | Normal/Visual | Format buffer/selection (conform) |
| `<leader>um` | Normal | Markdown: Browser preview toggle |
| `<leader>uM` | Normal | Markdown: In-buffer render toggle |
| `<leader>,` | Normal | Buffers: List/switch (Telescope) |
| `<leader>e` | Normal | Explorer: Toggle Neo-tree files |
| `<leader>ef` | Normal | Explorer: Reveal current file |
| `<leader>eb` | Normal | Explorer: Neo-tree buffers |
| `<leader>eg` | Normal | Explorer: Neo-tree git status |
| `<leader>gn` | Normal | gp.nvim: New chat |
| `<leader>gB` | Normal/Visual | gp.nvim: Brief chat |
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
| `]c` / `[c` | Normal | Git: Next/previous hunk |
| `<leader>hp` | Normal | Git: Preview hunk |
| `<leader>hi` | Normal | Git: Preview inline |
| `<leader>hs` / `<leader>hr` | Normal/Visual | Git: Stage/reset hunk or selection |
| `<leader>hS` / `<leader>hR` | Normal | Git: Stage/reset buffer |
| `<leader>hb` / `<leader>hB` | Normal | Git: Blame line / toggle inline blame |
| `<leader>hd` / `<leader>hD` | Normal | Git: Diff buffer / diff against HEAD~ |
| `<leader>hq` / `<leader>hQ` | Normal | Git: Buffer/all hunks to quickfix |
| `<leader>hw` | Normal | Git: Toggle word diff |
| `ih` | Operator/Visual | Git: Hunk text object |
| `<F5>` | Normal | DAP: Continue |
| `<F10>` | Normal | DAP: Step over |
| `<F11>` | Normal | DAP: Step into |
| `<F12>` | Normal | DAP: Step out |
| `<leader>db` | Normal | DAP: Toggle breakpoint |
| `<leader>dB` | Normal | DAP: Set breakpoint |
| `<leader>dr` | Normal | DAP: Open REPL |
| `<leader>du` | Normal | DAP: Toggle UI |
| `<C-g>` | Insert | Codeium: Accept inline suggestion |
| `<C-;>` | Insert | Codeium: Trigger inline suggestion |
| `<C-c>` | Insert | Codeium: Dismiss inline suggestion |
| `<leader>mn` | Normal | Multi: Add next match (vim-visual-multi) |
| `<leader>md` | Normal | Multi: Add cursor down (vim-visual-multi) |
| `<leader>mu` | Normal | Multi: Add cursor up (vim-visual-multi) |
| `<leader>ma` | Normal | Multi: Select all matches (vim-visual-multi) |
| `sa` | Normal/Visual | Surround: Add (mini.surround) |
| `sd` | Normal | Surround: Delete (mini.surround) |
| `sr` | Normal | Surround: Replace (mini.surround) |
| `sh` | Normal | Surround: Highlight (mini.surround) |
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
