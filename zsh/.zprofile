# ~/.zprofile - Login shell setup
# This file is sourced for login shells before .zshrc

# ── Homebrew Setup ──────────────────────────────────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"

# ── Environment Variables ───────────────────────────────────────
export CLICOLOR=1
export HOMEBREW_COLOR=1
export GREP_OPTIONS='--color=auto'
export FZF_DEFAULT_COMMAND='fd --type f'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESS='-R'
export BAT_THEME="Dracula"

# ── Path Setup ──────────────────────────────────────────────────
# Local binaries
export PATH="$PATH:/Users/allison/.local/bin"

# ── Antidote Setup ──────────────────────────────────────────────
ANTIDOTE_HOME="$HOME/.config/zsh"

# ── Load Aliases ────────────────────────────────────────────────
source "$HOME/.zaliases"

