#!/bin/bash
# backup.sh - Backup current configurations to dotfiles repo

set -euo pipefail

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Change to dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../" && pwd)"
cd "$DOTFILES_DIR"

log_info "Backing up current configurations to dotfiles repo..."

# Backup zsh configs
log_info "Backing up zsh configurations..."
cp ~/.zshenv zsh/ 2>/dev/null || true
cp ~/.zprofile zsh/ 2>/dev/null || true
cp ~/.zshrc zsh/ 2>/dev/null || true
cp ~/.zaliases zsh/ 2>/dev/null || true
cp ~/.zsh_plugins.txt zsh/ 2>/dev/null || true

# Backup git configs
log_info "Backing up git configurations..."
cp ~/.gitconfig git/ 2>/dev/null || true
cp ~/.gitconfig-github git/ 2>/dev/null || true
cp ~/.gitconfig-gitlab git/ 2>/dev/null || true

# Backup starship config
log_info "Backing up starship configuration..."
cp ~/.config/starship.toml starship/ 2>/dev/null || true

# Backup vim config
log_info "Backing up vim configuration..."
cp -r ~/.vim . 2>/dev/null || true

# Backup fzf config
log_info "Backing up fzf configuration..."
cp ~/.fzf.zsh fzf/ 2>/dev/null || true

# Backup asdf configs
log_info "Backing up asdf configurations..."
cp ~/.tool-versions asdf/ 2>/dev/null || true
cp ~/.python-version asdf/ 2>/dev/null || true

# Backup application configs
log_info "Backing up application configurations..."
cp -r ~/.config/gh config/ 2>/dev/null || true
cp -r ~/.config/glab-cli config/ 2>/dev/null || true
cp -r ~/.config/raycast config/ 2>/dev/null || true
cp -r ~/.config/spicetify config/ 2>/dev/null || true
cp -r ~/.config/rclone config/ 2>/dev/null || true

log_success "Backup complete! All configurations updated in dotfiles repo."
log_info "Don't forget to commit and push your changes:"
echo "  git add -A"
echo "  git commit -m 'Update configurations'"
echo "  git push"

