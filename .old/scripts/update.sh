#!/bin/bash
# update.sh - Update dotfiles and system tools

set -euo pipefail

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Change to dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../" && pwd)"
cd "$DOTFILES_DIR"

log_info "Updating dotfiles and system tools..."

# Update git repository
log_info "Pulling latest dotfiles from git..."
git pull origin main 2>/dev/null || git pull origin master 2>/dev/null || log_warning "Could not pull from git"

# Backup current configs
log_info "Backing up current configurations..."
./scripts/backup.sh

# Update Homebrew
log_info "Updating Homebrew packages..."
brew update && brew upgrade && brew cleanup

# Update ASDF plugins and tools
log_info "Updating ASDF plugins..."
asdf plugin update --all

log_info "Installing/updating ASDF tools..."
asdf install

# Update antidote plugins
log_info "Updating antidote plugins..."
rm -f ~/.zsh_plugins.zsh
antidote bundle <~/.zsh_plugins.txt >! ~/.zsh_plugins.zsh

# Rehash commands
log_info "Refreshing command paths..."
asdf reshim

log_success "Update complete!"
log_info "Next steps:"
echo "  1. Review changes: git status"
echo "  2. Commit if needed: git add -A && git commit -m 'Update configurations'"
echo "  3. Push changes: git push"
echo "  4. Restart terminal or run: source ~/.zshrc"

