# Codex instructions for this dotfiles repository

## Objective

Recreate and maintain the same macOS development environment provided by this repository:

```text
Ghostty
├── tmux via `dev-session`
│   ├── left pane: Neovim with LazyVim
│   └── right pane: Codex CLI
└── Herdr via `dev-herdr`
    ├── left pane: Codex CLI
    └── right pane: Neovim with LazyVim
```

The expected editor features are syntax highlighting, absolute and relative line numbers, Git gutter indicators, LSP diagnostics, autocomplete, file exploration, fuzzy file search, project-wide text search, a status line, and a dark muted theme. Supported languages include TypeScript, JavaScript, Python, JSON, YAML, Markdown, Lua, shell, HTML, and CSS.

## Setup procedure

1. Inspect the Mac before changing it. Check Homebrew, Ghostty, tmux, Herdr, Neovim, Codex CLI, Git, Node.js, Python, ripgrep, fd, fzf, jq, lazygit, and every target config path.
2. Install Homebrew from its official installer if it is missing. Request user approval before running the networked installer.
3. Run `~/dotfiles/bootstrap.sh`. Approve Homebrew and plugin downloads when prompted.
4. Do not manually replace active configs. The bootstrap script creates timestamped backups before linking repository files.
5. Complete every verification below and fix any warning or error caused by this setup.

## Repository map

- `Brewfile`: Homebrew formulae and casks.
- `.config/nvim`: complete LazyVim starter structure and pinned plugin lockfile.
- `.tmux.conf`: tmux navigation, colors, history, panes, and status bar.
- `ghostty/config.ghostty`: Ghostty theme and terminal settings.
- `.local/bin/dev-session`: tmux project launcher for the Neovim and Codex pane layout.
- `.local/bin/dev-herdr`: Herdr workspace launcher with optional directory selection.
- `shell/dev-environment.zsh`: adds `~/.local/bin` to the shell path.
- `bootstrap.sh`: idempotent installer, linker, tooling bootstrap, and verifier.

## Safety rules

- Preserve unrelated home-directory files.
- Before replacing a real file or directory, create a timestamped sibling backup.
- Never delete an existing config merely because a symbolic link is preferred.
- Do not edit generated changelogs.
- Do not commit secrets, caches, Neovim state, Mason packages, or machine-specific credentials.
- Keep `lazy-lock.json` tracked so plugin versions remain reproducible.
- Use Homebrew for Mac packages and LazyVim's normal starter structure for Neovim.

## Required verification

1. Run `nvim --headless -c "lua assert(vim.o.number and vim.o.relativenumber and vim.o.termguicolors)" -c qa` and require exit code 0 with no startup errors.
2. Start an isolated tmux server with `tmux -L dotfiles-config-test -f ~/.tmux.conf new-session -d -s config-test`, then stop it with `tmux -L dotfiles-config-test kill-server`.
3. Run `ghostty +show-config` and require successful parsing.
4. Run `sh -n ~/.local/bin/dev-session`.
5. Run `sh -n ~/.local/bin/dev-herdr` and confirm the Herdr server accepts workspace and pane API requests.
6. Confirm Mason contains the requested language servers and Tree-sitter contains the requested parsers.

## Handoff

Report the exact backup paths created, package or plugin failures encountered, and verification results. Do not claim completion while Neovim downloads are still running, while tmux reports a configuration error, or while Herdr reports a server error.
