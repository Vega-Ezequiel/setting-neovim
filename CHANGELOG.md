# Changelog

## [1.0.0] — 2026-06-29

### Added

- **Dashboard** — Startify-style two-pane dashboard with Ze77a ASCII header, green color palette, quick keys, recent files, and projects sections
- **File Explorer** — snacks.nvim explorer with custom keymaps: `n` (create), `r` (rename), `d` (delete), `o` (open), `m` (move)
- **Buffer Tabs** — bufferline.nvim with eager loading and `<leader>1`–`<leader>9` buffer navigation
- **Fuzzy Finding** — `<leader>ff` for file picker, `<C-f>` for grep in a top-right floating layout
- **Terminal** — Floating terminal via `<leader>cc`
- **Notifications** — Fancy-style notifier with 3s timeout, bottom-up direction
- **Smooth Scrolling** — Animated scroll with quadInOut easing (200ms total, 10ms step)
- **Git Integration** — Lazygit launcher via `<leader>gg`
- **Debug** — nvim-dap with DAP UI and virtual text for:
  - Node.js / JavaScript / TypeScript (inspector protocol)
  - Python (debugpy adapter)
  - Go (delve adapter)
- **Syntax Highlighting** — Treesitter with 18 language parsers
- **Icons** — mini.icons for file and UI icons
- **Custom Highlights** — Green dashboard palette: `#00ff00`, `#00cc00`, `#88ff88`, `#66ff66`, `#aaffaa`, `#55aa55`
- **Keymaps** — `ii` to exit insert mode, comprehensive `<leader>` shortcuts
- **PATH** — Local binaries (`~/.local/go/bin`, `~/go/bin`, `~/.local/bin`) automatically added to PATH

### Fixed

- Explorer keymaps placement corrected to `picker.sources.explorer.win.list.keys`
- nvim-dap-ui `nvim-nio` dependency added to fix config error
- nvim-dap-node disabled (archived repository), replaced with Node.js inspector protocol adapter

### Notes

- JetBrainsMono Nerd Font required for icon rendering
- Lazygit must be installed separately for Git integration
- Debug adapters require: debugpy (Python) and delve (Go) to be installed on the system
