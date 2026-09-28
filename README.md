# 🖥️ Neovim Config — Juanca Dev Environment

![Go](https://img.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white)
![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)

## Overview

Personal Neovim config for full-stack development with focus on **Go**, **PostgreSQL**, **Docker**, and **Git Worktrees**. Batteries included: LSP, debugging, testing, formatting, linting, and a dynamic cheatsheet.

Leader key: `,` (comma)

## Quick Start

```powershell
# 1. Prereqs (Windows + Chocolatey)
choco install -y git neovim nodejs-lts python3 go rust visualstudio2022-workload-vctools make ripgrep fd ruby postgresql18
gem install neovim
winget install jesseduffield.lazygit ImageMagick.ImageMagick

# 2. Clone & launch
git clone https://github.com/tu-usuario/neovim-config.git $env:LOCALAPPDATA\nvim
nvim  # Lazy.nvim installs plugins automatically

# 3. Inside Neovim
:Lazy sync
:MasonInstall gopls gofumpt goimports golines sqls stylua lua-language-server tailwindcss-language-server typescript-language-server eslint-lsp prettierd debugpy delve
:TSInstall go gomod gowork gotmpl sql lua python javascript typescript html css markdown markdown_inline json regex

# 4. Compile JSRegexp (for LuaSnip)
cd $env:LOCALAPPDATA\nvim-data\lazy\LuaSnip
make install_jsregexp
```

## Key Features

| Area | Tools |
|------|-------|
| **Editing** | Oil.nvim, Telescope, Treesitter, Lualine, Bufferline |
| **LSP** | gopls, lua_ls, ts_ls, pylsp, sqls, tailwindcss, + conform.nvim, nvim-lint |
| **Debug** | nvim-dap (Go, Python), DAP UI |
| **Test** | Neotest (Go adapter) |
| **Git** | Gitsigns, LazyGit, Worktree helpers |
| **DB** | vim-dadbod, sqls LSP, LazyDocker |
| **Snippets** | LuaSnip + friendly-snippets |
| **Theme** | Catppuccin Mocha + Nerd Fonts |

## Essential Keymaps

| Key | Action |
|-----|--------|
| `,w` / `,q` / `,ba` | Save / Close buffer / Close others |
| `-` | Oil file explorer |
| `gd` / `gi` / `gr` | Go to definition / implementation / references |
| `K` / `,d` / `,e` | Hover / Diagnostics float / Error float |
| `<leader>ff` / `fg` / `fb` | Find files / Live grep / Buffers |
| `<leader>ca` / `,rn` | Code actions / Rename |
| `<leader>db` / `dc` / `dn` | Debug: breakpoint / continue / step over |
| `nnr` / `nnf` / `nna` | Test: nearest / file / all |
| `<leader>tf` / `th` | Terminal: float / horizontal |
| `<leader>hp` / `hb` / `hd` | Git: preview hunk / blame / diff |
| `<leader>rq` / `bj` | SQL: run / run as JSON |
| `<leader>.` | Open dynamic cheatsheet |

> **Full keymaps**: Press `<leader>.` to open the auto-generated `CHEATSHEET.md` (synced from your config).

## Git Worktrees

Helper functions for PowerShell (`$PROFILE`):

```powershell
function New-GitWorktree { param([string]$BranchName, [string]$FolderName) ... }
Set-Alias gw New-GitWorktree
function Remove-GitWorktree { param([string]$Path) git worktree remove $Path }
Set-Alias gwr Remove-GitWorktree
```

Usage: `gw feature/xyz` → creates worktree in `../repo.worktrees/xyz/`

## Docker & Database

| Key | Action |
|-----|--------|
| `<leader>dps` | `docker ps` |
| `<leader>ddo` | `docker-compose down` |
| `<leader>dk` | Restart Go app container |
| `<leader>drb` | Rebuild & up (`down && up --build -d`) |

Set `DB_PASS_EEFF` env var for PostgreSQL (used by sqls LSP).

## Maintenance

```vim
:Lazy update      " Update plugins
:MasonUpdate      " Update LSPs/tools
:TSUpdate         " Update Treesitter parsers
:Lazy clean       " Remove unused plugins
:checkhealth      " Verify setup
```

## Secrets (.env)

Copy `.env.example` → `.env.local` (gitignored) for API keys, DB credentials, etc. Loaded automatically for CodeCompanion, sqls, etc.

## License

MIT — see `LICENSE`.

---

*Built for productivity. Enjoy coding! 🚀*