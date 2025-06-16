# 🚀 Allison's Kickass Dotfiles

> **Lightning-fast, organized, and beautifully managed development environment**

This repository contains my meticulously organized dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/) for seamless deployment across machines.

## ✨ What's Included

### 🐚 **Shell Configuration**
- **Zsh** with proper file organization (`.zshenv`, `.zprofile`, `.zshrc`, `.zaliases`)
- **Antidote** plugin manager with curated plugins
- **Starship** prompt with Dracula theme
- **FZF** integration with advanced tab completion

### 🛠️ **Development Tools**
- **ASDF** version management for 15+ languages/tools
- **Git** configuration with conditional includes
- **Vim** with Dracula theme
- **Tool versions** managed globally

### 🎨 **UI Tools**
- **Starship** prompt configuration
- **Raycast** settings
- **Spicetify** Spotify theming
- **GitHub CLI** and **GitLab CLI** configs

## 🚀 Quick Setup

### Prerequisites
```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Stow
brew install stow
```

### Installation
```bash
# Clone this repository
git clone https://github.com/[your-username]/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Deploy all configurations
./install.sh
```

### Manual Installation (Advanced)
```bash
# Deploy specific configurations
stow zsh      # Shell configuration
stow git      # Git configuration
stow starship # Prompt configuration
stow vim      # Vim configuration
stow asdf     # Tool versions
stow config   # Application configs
```

## 📁 Structure

```
dotfiles/
├── zsh/                    # Shell configuration
│   ├── .zshenv            # Environment variables
│   ├── .zprofile          # Login shell setup
│   ├── .zshrc             # Interactive shell config
│   ├── .zaliases          # Command aliases
│   └── .zsh_plugins.txt   # Antidote plugin list
├── git/                    # Git configuration
│   ├── .gitconfig         # Main git config
│   ├── .gitconfig-github  # GitHub-specific config
│   └── .gitconfig-gitlab  # GitLab-specific config
├── config/                  # Application configs
│   ├── starship.toml       # Starship prompt config
│   ├── gh/                 # GitHub CLI
│   ├── glab-cli/           # GitLab CLI
│   ├── raycast/            # Raycast
│   ├── spicetify/          # Spotify theming
│   └── rclone/             # Cloud storage sync
├── vim/                    # Vim configuration
│   └── .vim/              # Vim files
├── fzf/                    # FZF configuration
│   └── .fzf.zsh          # FZF shell integration
├── asdf/                   # Version management
│   ├── .tool-versions     # Global tool versions
│   └── .python-version    # Python version
└── scripts/                # Management scripts
    ├── install.sh         # Full installation
    ├── backup.sh          # Backup current configs
    └── update.sh          # Update dotfiles
```

## 🎯 Features

### **Lightning-Fast Shell**
- Optimized zsh configuration with proper file separation
- Antidote plugin manager for performance
- Advanced FZF tab completion with previews
- Dracula theme consistency across all tools

### **Unified Tool Management**
- ASDF manages 15+ development tools
- Global defaults that work everywhere
- Project-specific overrides via `.tool-versions`
- Clean PATH management

### **Beautiful Prompt**
- Starship prompt with Dracula colors
- Git status integration
- Command duration display
- Directory truncation

### **Smart Git Configuration**
- Conditional includes for GitHub/GitLab
- GPG signing enabled
- Auto-setup remote branches
- Rebase-first workflow

## 🔧 Customization

### Adding New Tools
1. Add to `asdf/.tool-versions`
2. Run `asdf plugin add <tool>` and `asdf install`
3. Commit changes

### Modifying Aliases
Edit `zsh/.zaliases` and run `reload` to apply changes.

### Updating Plugins
Modify `zsh/.zsh_plugins.txt` and restart your shell.

## 📋 Management Commands

```bash
# Update all tools
asdf plugin update --all
asdf install

# Update Homebrew packages
update  # (alias for brew update && brew upgrade && brew cleanup)

# Reload shell configuration
reload  # (alias for source ~/.zshrc)

# Edit configuration files
zshrc     # Edit .zshrc
aliases   # Edit .zaliases
zprofile  # Edit .zprofile
```

## 🔄 Synchronization

### Backup Current Config
```bash
./scripts/backup.sh
```

### Update Dotfiles
```bash
./scripts/update.sh
git add -A
git commit -m "Update configurations"
git push
```

### Deploy to New Machine
```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

## 🎨 Theme

This configuration uses the **Dracula** theme consistently across:
- Terminal colors
- Starship prompt
- Bat syntax highlighting
- Vim editor
- All supported applications

## 📱 Supported Applications

- **Zsh** - Shell
- **Starship** - Prompt
- **Git** - Version control
- **Vim** - Editor
- **FZF** - Fuzzy finder
- **GitHub CLI** - GitHub integration
- **GitLab CLI** - GitLab integration
- **Raycast** - macOS launcher
- **Spicetify** - Spotify theming
- **Rclone** - Cloud storage
- **ASDF** - Version management

## 🤝 Contributing

Feel free to fork this repository and adapt it to your needs! If you have improvements or suggestions, please open an issue or PR.

## 📄 License

MIT License - Feel free to use and modify as needed.

---

**Made with ❤️ and lots of ☕ by Allison**

