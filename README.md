# Ze77a Neovim Configuration

Personalized Neovim setup powered by [lazy.nvim](https://github.com/folke/lazy.nvim) with a green-themed dashboard, file explorer, buffer tabs, fuzzy finding, Git integration, and multi-language debug support.

## Features

- **Dashboard** — Startify-style two-pane dashboard with Ze77a ASCII art, quick keys, recent files, and projects
- **File Explorer** — `snacks.nvim` explorer with `n` (create), `r` (rename), `d` (delete), `o` (open), `m` (move)
- **Buffer Tabs** — Bufferline with `<leader>1`–`<leader>9` for quick buffer switching
- **Fuzzy Finder** — `<leader>ff` for files, `<C-f>` for grep (top-right floating window)
- **Terminal** — `<leader>cc` opens a floating terminal via `snacks.nvim`
- **Notifications** — Fancy-style notifications, 3s timeout, bottom-up
- **Smooth Scrolling** — Animated scrolling with `quadInOut` easing
- **Git Integration** — `<leader>gg` opens Lazygit
- **Debugging** — Full DAP support for Node.js/JavaScript/TypeScript, Python, and Go with UI and inline variable display
- **Syntax Highlighting** — Treesitter for 18+ languages

## Keymaps

| Key | Action |
|-----|--------|
| `<leader>nt` | Open file explorer |
| `<leader>cc` | Open terminal |
| `<leader>w` | Save file |
| `<leader>q` | Close current buffer (opens explorer if no buffers left) |
| `<leader>ff` | Find files |
| `<leader>gg` | Open Lazygit |
| `<C-f>` | Grep search (top-right) |
| `<leader>1`–`<leader>9` | Go to buffer n |
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue debug |
| `<leader>do` | Step over |
| `<leader>di` | Step into |
| `<leader>dO` | Step out |
| `<leader>dd` | Toggle DAP UI |
| `<leader>dl` | Run last debug |
| `<leader>dr` | Restart debug |
| `<leader>dq` | Terminate debug |
| `<leader>dB` | List breakpoints |
| `ii` | Exit insert mode |

## Project Structure

```
~/.config/nvim/
├── init.lua                  # Entry point: leader key, highlights, PATH, lazy bootstrap
├── lazy-lock.json            # Locked plugin versions
├── static/
│   └── ze77a.txt             # ASCII art for dashboard right pane
└── lua/
    └── plugins/
        ├── snacks.lua        # Core: dashboard, explorer, picker, terminal, notifier, scroll
        ├── bufferline.lua    # Buffer tabs with web devicons
        ├── dap.lua           # Debug adapter: Node.js, Python, Go (nvim-dap + dap-ui)
        ├── mini-icons.lua    # Icon provider via mini.icons
        └── treesitter.lua    # Syntax highlighting and indentation
```

## Installation

### Prerequisites

- **Neovim** >= 0.9.0 (recommended 0.10+)
- **Git**
- **Nerd Font** (JetBrainsMono Nerd Font recommended) — for icons and glyphs
- **lazygit** (optional, for `<leader>gg`)

### Linux

```bash
# Dependencies
sudo apt install git curl

# Lazygit (optional)
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# Python debug adapter
python3 -m pip install --user debugpy

# Go debug adapter (requires Go)
go install github.com/go-delve/delve/cmd/dlv@latest

# Nerd Font (optional, for icons)
mkdir -p ~/.local/share/fonts
wget -O /tmp/JetBrainsMono.zip "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
unzip /tmp/JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -fv

# Install config
git clone <your-repo-url> ~/.config/nvim
nvim --headless "+Lazy! sync" +qa
```

### macOS

```bash
# Homebrew
brew install git lazygit go

# Python debug adapter
pip3 install --user debugpy

# Go debug adapter
go install github.com/go-delve/delve/cmd/dlv@latest

# Nerd Font
brew install --cask font-jetbrains-mono-nerd-font

# Install config
git clone <your-repo-url> ~/.config/nvim
nvim --headless "+Lazy! sync" +qa
```

### Windows

```powershell
# Using Chocolatey
choco install git lazygit golang

# Python debug adapter
python -m pip install --user debugpy

# Go debug adapter
go install github.com/go-delve/delve/cmd/dlv@latest

# Nerd Font — download and install JetBrainsMono Nerd Font from:
# https://www.nerdfonts.com/font-downloads

# Install config
git clone <your-repo-url> $env:USERPROFILE\AppData\Local\nvim
nvim --headless "+Lazy! sync" +qa
```

**Note:** On Windows, the config path is `$env:USERPROFILE\AppData\Local\nvim` and `init.lua` should be placed there directly. The `lua/plugins/` directory works the same way.

## Adding New Plugins

1. Create a new file in `lua/plugins/` (e.g., `lua/plugins/my-plugin.lua`)
2. Write the plugin spec following the lazy.nvim format:

```lua
return {
  {
    "author/plugin-name",
    dependencies = { "other/plugin" },  -- optional
    opts = {
      -- plugin options
    },
    -- or use config = function() ... end
    keys = {
      { "<leader>x", "<Cmd>SomeCommand<CR>", desc = "Description" },
    },
  },
}
```

3. Run `nvim --headless "+Lazy! sync" +qa` or just open nvim and Lazy will install it automatically.

## Customization

- **Green palette** — Edit the `vim.api.nvim_set_hl` calls in `init.lua` (lines 17–23)
- **Dashboard keys** — Modify the `preset.keys` table in `lua/plugins/snacks.lua`
- **LazyGit path** — Ensure `lazygit` is in your PATH, or configure via `Snacks.lazygit()`
- **DAP configurations** — Add more adapters/configurations in `lua/plugins/dap.lua`
- **PATH** — Custom PATH entries are added in `init.lua` lines 10–12

## License

MIT
