# Reconstructed .zshrc - Mise-first approach
# Updated: 2025-10-05

# ── History Configuration ─────────────────────────────────────
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=50000

# History options for better behavior
setopt share_history           # Share history across all sessions
setopt hist_ignore_all_dups    # Remove older duplicate entries from history
setopt hist_find_no_dups       # Don't show duplicates when searching
setopt hist_reduce_blanks      # Remove superfluous blanks from history
setopt hist_verify             # Show command with history expansion before running
setopt inc_append_history      # Add commands immediately, not at shell exit
setopt extended_history        # Record timestamp of command

# ── Mise Activation ───────────────────────────────────────────
# Mise manages all development tools (node, python, rust, go, etc.)
eval "$(~/.local/bin/mise activate zsh)"

# ── Antidote Plugin Manager ────────────────────────────────────
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load ${ZDOTDIR:-~}/.zsh_plugins.txt

# ── Completion Setup ──────────────────────────────────────────
autoload -Uz compinit colors
compinit -C
colors

# Better completion matching
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ── Key Bindings ──────────────────────────────────────────────
# Ctrl+Space to accept autosuggestion
bindkey '^ ' autosuggest-accept

# Ctrl+arrow keys for word navigation
bindkey '^[[1;5C' forward-word      # Ctrl+RightArrow
bindkey '^[[1;5D' backward-word     # Ctrl+LeftArrow

# Alt+arrow keys for word navigation (alternative)
bindkey '^[[1;3C' forward-word      # Alt+RightArrow
bindkey '^[[1;3D' backward-word     # Alt+LeftArrow

# Better history search with up/down arrows
bindkey '^[[A' history-search-backward  # Up arrow
bindkey '^[[B' history-search-forward   # Down arrow

# Home/End keys
bindkey '^[[H' beginning-of-line    # Home
bindkey '^[[F' end-of-line          # End

# Delete key
bindkey '^[[3~' delete-char         # Delete

# ── Tool Initialization ───────────────────────────────────────
# Starship prompt
eval "$(starship init zsh)"

# Zoxide (smart cd)
eval "$(zoxide init zsh)"

# ── Aliases ───────────────────────────────────────────────────
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias grep='grep --color=auto'

# Modern replacements (if available)
command -v eza &>/dev/null && alias ls='eza --icons'
command -v bat &>/dev/null && alias cat='bat'

# Claude Code
alias claude="/home/Allie/.claude/local/claude"

# Git shortcuts
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'

# Mise shortcuts
alias mr='mise run'
alias mi='mise install'
alias mu='mise use'
