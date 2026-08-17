#!/bin/sh

set -eu

repository_directory=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
backup_timestamp=$(date +%Y%m%d-%H%M%S)

back_up_and_link() {
  source_path=$1
  target_path=$2
  target_directory=$(dirname "$target_path")

  mkdir -p "$target_directory"

  if [ -L "$target_path" ] && [ "$(readlink "$target_path")" = "$source_path" ]; then
    printf 'Already linked: %s\n' "$target_path"
    return
  fi

  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    backup_path="${target_path}.backup-${backup_timestamp}"
    mv "$target_path" "$backup_path"
    printf 'Backed up: %s -> %s\n' "$target_path" "$backup_path"
  fi

  ln -s "$source_path" "$target_path"
  printf 'Linked: %s -> %s\n' "$target_path" "$source_path"
}

if ! command -v brew >/dev/null 2>&1; then
  printf '%s\n' 'Homebrew is required. Install it from https://brew.sh, then rerun this script.' >&2
  exit 1
fi

brew bundle --file "$repository_directory/Brewfile"

back_up_and_link "$repository_directory/.config/nvim" "$HOME/.config/nvim"
back_up_and_link "$repository_directory/.tmux.conf" "$HOME/.tmux.conf"
back_up_and_link "$repository_directory/.local/bin/dev-session" "$HOME/.local/bin/dev-session"
back_up_and_link "$repository_directory/.local/bin/dev-herdr" "$HOME/.local/bin/dev-herdr"
back_up_and_link "$repository_directory/ghostty/config.ghostty" "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
back_up_and_link "$repository_directory/shell/dev-environment.zsh" "$HOME/.config/shell/dev-environment.zsh"

chmod 755 "$repository_directory/.local/bin/dev-session" "$repository_directory/.local/bin/dev-herdr"

shell_source_line='source "$HOME/.config/shell/dev-environment.zsh"'
touch "$HOME/.zshrc"
if ! grep -Fqx "$shell_source_line" "$HOME/.zshrc"; then
  cp "$HOME/.zshrc" "$HOME/.zshrc.backup-${backup_timestamp}"
  printf '\n%s\n' "$shell_source_line" >> "$HOME/.zshrc"
  printf 'Updated ~/.zshrc after creating a timestamped backup.\n'
fi

nvim --headless "+Lazy! sync" +qa
nvim --headless \
  -c "lua require('lazy').load({ plugins = { 'mason.nvim' } })" \
  -c "MasonInstall bash-language-server css-lsp html-lsp json-lsp lua-language-server marksman basedpyright vtsls yaml-language-server markdown-toc markdownlint-cli2 prettier stylua shfmt" \
  -c qall
nvim --headless \
  -c "lua require('nvim-treesitter').install({ 'bash', 'css', 'html', 'javascript', 'json', 'lua', 'markdown', 'markdown_inline', 'python', 'tsx', 'typescript', 'vim', 'vimdoc', 'yaml' }):wait(300000)" \
  -c qa

nvim --headless \
  -c "lua assert(vim.o.number and vim.o.relativenumber and vim.o.termguicolors); print('Neovim configuration verified')" \
  -c qa

tmux -L dotfiles-config-test -f "$HOME/.tmux.conf" new-session -d -s config-test
tmux -L dotfiles-config-test kill-server

ghostty +show-config >/dev/null
sh -n "$HOME/.local/bin/dev-session"
sh -n "$HOME/.local/bin/dev-herdr"

printf '%s\n' 'Environment installed and verified. Open a new Ghostty window and run: dev-session or dev-herdr'
