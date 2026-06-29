# Ze77a Neovim Configuration

Personalized Neovim setup powered by [lazy.nvim](https://github.com/folke/lazy.nvim) with a green-themed dashboard, file explorer, buffer tabs, fuzzy finding, Git integration, **AI assistance via MiniMax** (CodeCompanion), and multi-language debug support.

## Features

- **Dashboard** — Startify-style two-pane dashboard with Ze77a ASCII art, quick keys, recent files, and projects
- **File Explorer** — `snacks.nvim` explorer with `n` (create), `r` (rename), `d` (delete), `o` (open), `m` (move)
- **Buffer Tabs** — Bufferline with `<leader>1`–`<leader>9` for quick buffer switching
- **Fuzzy Finder** — `<leader>ff` for files, `<C-f>` for grep (top-right floating window)
- **Terminal** — `<leader>cc` opens a floating terminal via `snacks.nvim`
- **Notifications** — Fancy-style notifications, 3s timeout, bottom-up
- **Smooth Scrolling** — Animated scrolling
- **Git Integration** — `<leader>gg` opens Lazygit
- **AI Integration (MiniMax)** — CodeCompanion.nvim with a custom **MiniMax** adapter (Anthropic-compatible API). Provides chat with `MiniMax-M3` / `MiniMax-M2.5` / `MiniMax-M2.7`, inline prompts, streaming responses, and diff preview
- **Debugging** — Full DAP support for Node.js/JavaScript/TypeScript, Python, and Go with UI and inline variable display
- **Syntax Highlighting** — Treesitter for 18+ languages

## Keymaps

| Key | Mode | Action |
|-----|------|--------|
| `<leader>nt` | n | Open file explorer |
| `<leader>cc` | n | Open terminal |
| `<leader>w` | n | Save file |
| `<leader>q` | n | Close current buffer (opens explorer if no buffers left, quits Neovim if called twice) |
| `<leader>ff` | n | Find files |
| `<leader>gg` | n | Open Lazygit |
| `<C-f>` | n | Grep search (top-right) |
| `<leader>1`–`<leader>9` | n | Go to buffer n |
| `<leader>a` | n | Toggle MiniMax AI Chat |
| `<leader>A` | n/v | MiniMax AI Inline Prompt |
| `ga` | v | Add visual selection to AI chat as context |
| `<leader>db` | n | Toggle breakpoint |
| `<leader>dc` | n | Continue debug |
| `<leader>do` | n | Step over |
| `<leader>di` | n | Step into |
| `<leader>dO` | n | Step out |
| `<leader>dd` | n | Toggle DAP UI |
| `<leader>dl` | n | Run last debug |
| `<leader>dr` | n | Restart debug |
| `<leader>dq` | n | Terminate debug |
| `<leader>dB` | n | List breakpoints |
| `ii` | i | Exit insert mode |

## Project Structure

```
~/.config/nvim/
├── init.lua                  # Entry point: leader key, highlights, PATH, lazy bootstrap
├── lazy-lock.json            # Locked plugin versions
├── README.md
├── CHANGELOG.md
├── static/
│   └── ze77a.txt             # ASCII art for dashboard right pane
└── lua/
    └── plugins/
        ├── snacks.lua        # Core: dashboard, explorer, picker, terminal, notifier, scroll
        ├── bufferline.lua    # Buffer tabs with web devicons
        ├── dap.lua           # Debug adapter: Node.js, Python, Go (nvim-dap + dap-ui)
        ├── mini-icons.lua    # Icon provider via mini.icons
        ├── treesitter.lua    # Syntax highlighting and indentation
        └── codecompanion.lua # AI integration: MiniMax adapter for chat/inline prompts
```

## Installation

### Prerequisites

- **Neovim** >= 0.9.0 (recommended 0.10+)
- **Git**
- **Nerd Font** (JetBrainsMono Nerd Font recommended) — for icons and glyphs
- **lazygit** (optional, for `<leader>gg`)
- **MiniMax account & API key** (required for AI features) — register at https://platform.minimax.io
- **Internet connection** (for AI requests)

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

# MiniMax API key (required for AI features)
export MINIMAX_API_KEY="your-minimax-api-key"
# To make it permanent, add to ~/.bashrc or ~/.zshrc:
echo 'export MINIMAX_API_KEY="your-minimax-api-key"' >> ~/.bashrc

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

# MiniMax API key (required for AI features)
export MINIMAX_API_KEY="your-minimax-api-key"
echo 'export MINIMAX_API_KEY="your-minimax-api-key"' >> ~/.zshrc

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

# MiniMax API key (required for AI features)
[System.Environment]::SetEnvironmentVariable("MINIMAX_API_KEY", "your-minimax-api-key", "User")

# Install config
git clone <your-repo-url> $env:USERPROFILE\AppData\Local\nvim
nvim --headless "+Lazy! sync" +qa
```

**Note:** On Windows, the config path is `$env:USERPROFILE\AppData\Local\nvim` and `init.lua` should be placed there directly. The `lua/plugins/` directory works the same way.

## AI Setup (MiniMax via CodeCompanion)

This config ships with a custom **MiniMax** adapter for [codecompanion.nvim](https://github.com/olimorris/codecompanion.nvim), using MiniMax's **Anthropic-compatible API**.

### Required environment variable

| Variable | Description |
|----------|-------------|
| `MINIMAX_API_KEY` | Your MiniMax API key — get one at https://platform.minimax.io |

Make sure this is set in your shell profile so Neovim inherits it on startup. To verify inside Neovim:

```vim
:lua print(vim.env.MINIMAX_API_KEY ~= nil and "set" or "missing")
```

### Available models

| Model | Context | Use case |
|-------|---------|----------|
| `MiniMax-M3` | 1M tokens | Flagship, deep reasoning, tool use |
| `MiniMax-M2.5` | 128K | Coding, balanced speed |
| `MiniMax-M2.7` | 128K | Balance between quality and speed |

Change the default model in `lua/plugins/codecompanion.lua` (line 20) — set `schema.model.default` to any of the above.

### Commands reference

| Command | Description |
|---------|-------------|
| `:CodeCompanionChat Toggle` | Open/close chat buffer |
| `:CodeCompanionChat Add` | Add visual selection to chat as context |
| `:CodeCompanion` | Open inline prompt (writes response into buffer) |
| `:CodeCompanion adapter=minimax model=MiniMax-M3` | Switch model on the fly |

### CodeCompanion chat variables

Inside the chat buffer, you can reference editor state with:

- `@lsp` — attach current LSP diagnostics
- `@buffers` — include other open buffers as context
- `@this` — the current buffer

### Troubleshooting

| Issue | Fix |
|-------|-----|
| `API key not configured` | Verify `MINIMAX_API_KEY` is exported in the shell that launches Neovim |
| `401 Unauthorized` | API key is wrong/expired — generate a new one at platform.minimax.io |
| `connection refused` / timeout | Check internet; the endpoint is `https://api.minimax.io` |
| `Failed to run config` for codecompanion | Run `:Lazy sync` — `nvim-lua/plenary.nvim` and `nvim-treesitter` must be installed first |

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
- **AI default model** — Change `schema.model.default` in `lua/plugins/codecompanion.lua`
- **PATH** — Custom PATH entries are added in `init.lua` lines 10–12

## License

MIT

