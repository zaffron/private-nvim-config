# Neovim Configuration

A personal Neovim configuration built around Neovim's **built-in plugin manager**
(`vim.pack`). No external plugin manager (lazy.nvim, packer, etc.) required.

## Features

- **Plugin management** via the native `vim.pack` API with lazy-loading on
  `UIEnter`, filetype, command, and keymap triggers
- **Colorscheme**: [catppuccin](https://github.com/catppuccin/nvim)
- **LSP**: `nvim-lspconfig` + `mason.nvim` with auto-installed servers
  (TypeScript, Lua, Python, Go, Rust, Tailwind, Terraform, Docker, and more)
- **Completion**: [blink.cmp](https://github.com/Saghen/blink.cmp) with
  [supermaven](https://github.com/supermaven-inc/supermaven-nvim) AI suggestions
- **Treesitter**, **fzf-lua** fuzzy finding, **neo-tree** file explorer
- **Git**: gitsigns, lazygit, neogit, diffview
- **Testing & Debugging**: neotest + nvim-dap
- **Formatting**: conform.nvim (stylua, black/isort, gofmt, prettier, shfmt, ...)
- **Image rendering** in Markdown/Norg/Typst via
  [image.nvim](https://github.com/3rd/image.nvim)

## Requirements

- **Neovim 0.12+** (the `vim.pack` plugin manager is required)
- **git** — used to clone plugins
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- Language toolchains for the LSP servers / formatters you use
  (Node.js, Python, Go, Rust, etc.)

## External CLI dependencies

Several plugins shell out to external command-line tools. Neovim still starts
without them, but the related features stay disabled until the tools are on your
`PATH`.

| Tool | Used by | Purpose |
|------|---------|---------|
| [`fzf`](https://github.com/junegunn/fzf) | fzf-lua | Fuzzy finder engine |
| [`ripgrep`](https://github.com/BurntSushi/ripgrep) (`rg`) | fzf-lua | Live grep / text search |
| [`fd`](https://github.com/sharkdp/fd) | fzf-lua | Fast file finding |
| [`lazygit`](https://github.com/jesseduffield/lazygit) | lazygit.nvim (`<leader>lg`) | Terminal git UI |
| `git` | vim.pack, gitsigns, neogit, diffview | Plugin cloning + all git features |
| [`imagemagick`](https://imagemagick.org/) (`magick`) | image.nvim | Inline image rendering (see below) |
| C compiler + `git` | nvim-treesitter | Compiling parsers |

### Formatter binaries (conform.nvim)

Formatting on save uses whichever of these are installed for the relevant
filetype. Most are auto-installable through `:Mason`, or via your package
manager:

- `stylua` (Lua)
- `black`, `isort` (Python)
- `prettierd` / `prettier`, `markdownlint-cli2`, `markdown-toc` (web + Markdown)
- `gofmt`, `goimports` (Go)
- `shfmt` (shell)

### Install on macOS (Homebrew)

```sh
brew install fzf ripgrep fd lazygit imagemagick
# common formatters
brew install stylua shfmt
```

> LSP servers themselves are managed automatically by `mason.nvim` — you don't
> install those by hand.

## Installation

> Back up any existing config first: `mv ~/.config/nvim ~/.config/nvim.bak`

```sh
git clone <this-repo-url> ~/.config/nvim
nvim
```

On first launch, `vim.pack` clones all plugins automatically and Mason installs
the configured LSP servers. Give it a moment, then restart Neovim.

The leader key is **`<Space>`**.

## Image rendering (optional)

To view images inline (in Markdown, Norg, and Typst files) you need:

1. **ImageMagick** — provides the `magick` CLI that `image.nvim` uses to decode
   and resize images.
2. **A terminal that supports the [kitty graphics protocol](https://sw.kovidgoyal.net/kitty/graphics-protocol/)** —
   e.g. [Kitty](https://sw.kovidgoyal.net/kitty/),
   [WezTerm](https://wezterm.org/), or [Ghostty](https://ghostty.org/).
   The config uses the `kitty` backend.

### Install ImageMagick

**macOS (Homebrew):**

```sh
brew install imagemagick
```

**Linux:**

```sh
# Debian / Ubuntu
sudo apt install imagemagick

# Arch
sudo pacman -S imagemagick

# Fedora
sudo dnf install ImageMagick
```

Verify the CLI is on your `PATH`:

```sh
magick --version
```

That's it — open a Markdown file containing an image and it renders inline.
Inside **tmux**, image rendering also works, but make sure your tmux/terminal
combination passes through the graphics protocol.

> If images don't appear, confirm you launched Neovim inside a kitty-protocol
> terminal and that `magick` resolves on your `PATH`.

## Structure

```
init.lua                  -- entry point
lua/config/pack.lua       -- plugin list + lazy-load orchestration
lua/zaffron/              -- core editor options, keymaps, LSP setup
lua/plugins/              -- per-plugin configuration
```
