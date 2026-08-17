# Mac development dotfiles

This repository recreates a Ghostty, tmux, Herdr, Neovim, LazyVim, and Codex CLI development environment on macOS.

## Install

1. Clone this repository to `~/dotfiles`.
2. Install Homebrew from <https://brew.sh> if it is not already installed.
3. Run `~/dotfiles/bootstrap.sh`.
4. Open a new Ghostty window.
5. Change to a project directory and run `dev-session` or `dev-herdr`.

The bootstrap script installs dependencies with Homebrew, creates timestamped backups of existing targets, links the tracked configs into place, installs LazyVim tooling, and verifies the result.

## tmux layout

`dev-session` starts a tmux session named after the current directory:

```text
Ghostty
└── tmux
    ├── left pane: Neovim with LazyVim
    └── right pane: Codex CLI
```

Pass a different session name when needed: `dev-session my-session`.

## Herdr layout

`dev-herdr` creates a Herdr workspace with the same project directory in all panes:

```text
Herdr workspace
├── left pane: Neovim with LazyVim
└── right column
    ├── upper pane: Codex CLI
    └── lower pane: terminal
```

Use `dev-herdr` outside Herdr to start or attach to the Herdr server in the current directory. Run it inside Herdr with no arguments to choose a workspace directory with `fzf`, or pass a directory explicitly:

```sh
dev-herdr
dev-herdr --select ~/Documents/Projects
dev-herdr ~/Documents/Projects/my-project
```

## Important keybindings

| Keys | Action |
| --- | --- |
| `Ctrl-h/j/k/l` | Move across Neovim splits and tmux panes |
| `Space e` | Toggle the file explorer |
| `Space Space` | Find files |
| `Space /` | Search project text |
| `gd`, `K`, `[d`, `]d` | Definition, documentation, and diagnostics |
| `Ctrl-b \|` and `Ctrl-b -` | Split tmux horizontally and vertically |
| `Ctrl-b H/J/K/L` | Resize the active tmux pane |

Herdr uses the same `Ctrl-b` prefix for pane navigation and splitting. `Ctrl-b v` splits right, `Ctrl-b -` splits down, and `Ctrl-b q` detaches while keeping workspaces running.

## Updating

Edit the files in `~/dotfiles`. The active configuration paths are symbolic links, so changes are immediately reflected in the repository.
