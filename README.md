# 🦄 Allie's Dotfiles

> **Mise-first, Linux-native, beautifully crafted development environment**

My personal dotfiles for Fedora Linux, built around a **mise-first philosophy** for unified tool management. Everything you need for a fast, productive, and aesthetically pleasing development setup.

## ✨ Philosophy

**Mise-First Approach:** All development tools are managed through [mise](https://mise.jdx.dev/), providing consistent versions across projects and machines. No more juggling asdf, nvm, pyenv, rbenv, etc. — mise handles it all.

**Linux Native:** Built for Fedora Linux with KDE Plasma, but adaptable to other distros.

**Minimal & Fast:** Only the essentials, optimized for quick shell startup and maximum productivity.

## 🛠️ Tech Stack

### Core Tools
- **Shell:** Zsh (primary) + Bash (with Starship)
- **Prompt:** [Starship](https://starship.rs/) with Dracula theme & unicorn 🦄
- **Version Manager:** [Mise](https://mise.jdx.dev/) for everything
- **Terminal:** [Ghostty](https://ghostty.org/)
- **Editor:** [Neovim](https://neovim.io/) with [LazyVim](https://www.lazyvim.org/)

### Development Languages (via Mise)
- **Node.js** 24.9.0 (latest)
- **Python** 3.13.7 (latest)
- **Rust** 1.90.0 (latest)
- **Go** 1.25.1 (latest)

### CLI Tools
- **lazygit** - Terminal UI for git
- **zoxide** - Smart directory jumper
- **gh** - GitHub CLI
- **eza** - Modern `ls` replacement
- **bat** - Better `cat` with syntax highlighting

### AI/LLM Tools
- **Claude Code** - AI coding assistant (locally installed)
- **Gemini CLI** - Google's AI assistant
- **OpenAI Codex** - OpenAI's coding assistant

## 📁 Structure

```
dotfiles/
├── bash/
│   └── .bashrc              # Bash with Starship & Mise
├── zsh/
│   ├── .zshrc               # Zsh config with history & bindings
│   └── .zsh_plugins.txt     # Antidote plugins
├── mise/
│   └── config.toml          # Tool versions & configuration
├── starship/
│   └── starship.toml        # Prompt configuration (Dracula theme)
├── ghostty/
│   └── config               # Terminal configuration
├── git/
│   ├── .gitconfig           # Git configuration
│   └── .gitignore_global    # Global gitignore patterns
├── nvim/                    # Neovim configuration (LazyVim)
├── neofetch/
│   └── config.conf          # System info display
└── konsole/
    └── Dracula.colorscheme  # KDE Konsole Dracula theme
```

## 🚀 Quick Start

### Prerequisites

```bash
# Install mise (if not already installed)
curl https://mise.run | sh

# Install starship
curl -sS https://starship.rs/install.sh | sh

# Install antidote (zsh plugin manager)
git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
```

### Installation

```bash
# Clone this repository
git clone git@github.com:alliecatowo/dotfiles.git ~/develop/dotfiles
cd ~/develop/dotfiles

# Symlink configurations (choose what you need)
ln -sf ~/develop/dotfiles/bash/.bashrc ~/.bashrc
ln -sf ~/develop/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/develop/dotfiles/zsh/.zsh_plugins.txt ~/.zsh_plugins.txt
ln -sf ~/develop/dotfiles/mise/config.toml ~/.config/mise/config.toml
ln -sf ~/develop/dotfiles/starship/starship.toml ~/.config/starship.toml
ln -sf ~/develop/dotfiles/ghostty/config ~/.config/ghostty/config
ln -sf ~/develop/dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/develop/dotfiles/git/.gitignore_global ~/.gitignore_global
ln -sf ~/develop/dotfiles/nvim ~/.config/nvim

# Install mise tools
mise install
```

### First Run

```bash
# Restart your shell or source the config
exec zsh
# or
source ~/.zshrc

# Verify mise is working
mise doctor

# Check installed tools
mise ls
```

## ⚡ Features

### Mise-First Tool Management
- **Unified interface** for all language versions and tools
- **Project-specific versions** via `.mise.toml` or `.tool-versions`
- **Global defaults** in `~/.config/mise/config.toml`
- **No PATH pollution** - mise handles shimming intelligently

### Shell Configuration

#### Zsh Improvements
- **Smart history:** 50,000 lines, shared across sessions, de-duplicated
- **Better bindings:** Ctrl/Alt + arrows for word navigation, improved search
- **Modern tools:** Syntax highlighting, autosuggestions, completions
- **Fast startup:** Optimized plugin loading with antidote

#### Bash Support
- **Starship prompt** (matching zsh)
- **Mise integration** for consistent environment
- **Useful aliases** for productivity

### Starship Prompt
- **Dracula color scheme** for consistency
- **Git integration** with detailed status icons
- **Language detection** (Python, Rust, Go, Node.js)
- **Mise indicator** showing active tool versions
- **Performance optimized** with 500ms timeout

### Git Configuration
- **GPG signing** enabled by default
- **Auto-setup remote** branches on push
- **Rebase-first** workflow (no merge commits on pull)
- **GitHub credential helper** via `gh` CLI

## 🎨 Theming

Everything uses the **Dracula** color scheme for visual consistency:
- Starship prompt (Dracula palette)
- Konsole terminal (Dracula.colorscheme)
- Ghostty terminal (configured for Dracula)
- Neovim (LazyVim with Dracula)

**Unicorn prompt:** Because we're fabulous 🦄

## 🔧 Customization

### Adding New Tools

```bash
# Add a new tool to mise
mise use -g node@22           # Install & set as global default
mise use python@3.12          # Project-specific version

# Edit mise config directly
nvim ~/.config/mise/config.toml
```

### Modifying Aliases

Edit `zsh/.zshrc` or `bash/.bashrc` and reload:
```bash
source ~/.zshrc  # or ~/.bashrc
```

### Updating Tools

```bash
# Update all mise tools
mise upgrade

# Update specific tool
mise upgrade node

# Update shell plugins
rm ~/.zsh_plugins.zsh
exec zsh
```

## 📋 Common Commands

### Mise
```bash
mise ls                  # List installed tools
mise use node@latest     # Use latest node version
mise install             # Install all tools from config
mise doctor              # Check mise health
```

### Git
```bash
gs                      # git status
ga .                    # git add
gc -m "message"         # git commit
gp                      # git push
gl                      # git pull
```

### Navigation
```bash
z <directory>           # Jump to directory (zoxide)
..                      # cd ..
...                     # cd ../..
```

## 🔄 Syncing Across Machines

### Backup Current Config
```bash
cd ~/develop/dotfiles
# Make changes to configs
git add -A
git commit -m "Update configurations"
git push
```

### Deploy to New Machine
```bash
git clone git@github.com:alliecatowo/dotfiles.git ~/develop/dotfiles
cd ~/develop/dotfiles
# Follow installation steps above
```

## 🎯 Why Mise?

Coming from asdf, Homebrew, nvm, pyenv, etc., **mise** consolidates everything:

- ✅ **Faster** than asdf (written in Rust)
- ✅ **Compatible** with asdf plugins & `.tool-versions`
- ✅ **More features** (tasks, env vars, templates)
- ✅ **Better UX** (clearer errors, helpful messages)
- ✅ **Single tool** for everything

## 📱 Supported Tools & Apps

### Configured
- Zsh - Shell
- Bash - Alternative shell
- Starship - Prompt
- Git - Version control
- Neovim - Editor
- Ghostty - Terminal
- Konsole - KDE terminal
- Neofetch - System info
- Mise - Version manager

### Managed by Mise
- Node.js, Python, Rust, Go
- lazygit, gemini-cli, codex
- Any tool with mise/asdf plugin support

## 🤝 Contributing

These are my personal dotfiles, but feel free to fork and adapt them! If you find improvements, open an issue or PR.

## 📄 License

MIT License - Use freely and adapt to your needs.

---

**Made with 🦄 and ❤️ by Allie**

*Powered by mise, starship, and way too much coffee ☕*
