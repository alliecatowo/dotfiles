#!/bin/bash
# install.sh - Deploy dotfiles using GNU Stow

set -euo pipefail

# Colors for pretty output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    log_error "GNU Stow is not installed. Please install it first:"
    echo "  brew install stow"
    exit 1
fi

# Change to dotfiles directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

log_info "Deploying dotfiles from $DOTFILES_DIR"

# Backup existing files
log_info "Creating backup of existing configurations..."
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Files to backup
backup_files=(
    ".zshenv"
    ".zprofile" 
    ".zshrc"
    ".zaliases"
    ".zsh_plugins.txt"
    ".gitconfig"
    ".gitconfig-github"
    ".gitconfig-gitlab"
    ".fzf.zsh"
    ".tool-versions"
    ".python-version"
    ".vim"
    ".config/starship.toml"
)

for file in "${backup_files[@]}"; do
    if [[ -e "$HOME/$file" ]]; then
        log_info "Backing up $file"
        cp -r "$HOME/$file" "$BACKUP_DIR/" 2>/dev/null || true
    fi
done

log_success "Backup created at $BACKUP_DIR"

# Deploy configurations
log_info "Deploying configurations..."

# Array of stow packages to deploy
packages=(
    "zsh"
    "git"
    "vim"
    "fzf"
    "asdf"
)

# Deploy each package
for package in "${packages[@]}"; do
    if [[ -d "$package" ]]; then
        log_info "Deploying $package configuration..."
        stow -v "$package"
        log_success "$package deployed successfully"
    else
        log_warning "Package directory $package not found, skipping..."
    fi
done

# Handle starship config separately (goes to .config)
if [[ -d "starship" ]]; then
    log_info "Deploying starship configuration..."
    mkdir -p "$HOME/.config"
    stow -t "$HOME/.config" starship
    log_success "Starship deployed successfully"
fi

# Handle .config applications
if [[ -d "config" ]]; then
    log_info "Deploying application configurations..."
    mkdir -p "$HOME/.config"
    stow -t "$HOME/.config" config
    log_success "Application configs deployed successfully"
fi

log_success "\n🎉 Dotfiles deployment complete!"
log_info "\nNext steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Install ASDF plugins: asdf plugin update --all && asdf install"
echo "  3. Update antidote plugins: rm ~/.zsh_plugins.zsh && restart terminal"
echo "\nBackup location: $BACKUP_DIR"
echo "\nEnjoy your new setup! 🚀"

