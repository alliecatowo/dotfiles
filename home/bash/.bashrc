# ~/.bashrc: non-interactive bash (scripts, agent tool calls with BASH_ENV) reads only the
# block above the interactive guard, so keep that block side-effect free.
# Machine-specific additions go in ~/.bashrc.local (never tracked).

[[ -f /etc/bashrc ]] && source /etc/bashrc

if [[ -x /opt/homebrew/bin/brew ]]; then eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d /opt/homebrew/bin ]]; then PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"; fi
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) PATH="$HOME/.local/bin:$PATH" ;; esac
export PATH

# Shims, not activate: non-interactive shells have no prompt hook to update PATH.
command -v mise >/dev/null && eval "$(mise activate bash --shims)"

[[ -r ~/.bashrc.local ]] && source ~/.bashrc.local

case $- in *i*) ;; *) return 0 ;; esac

# ── Interactive only ──────────────────────────────────────────
eval "$(mise activate bash)"
HISTSIZE=50000
HISTFILESIZE=50000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend checkwinsize

eval "$(zoxide init bash)"
eval "$(starship init bash)"

alias ls='eza --icons=auto'
alias ll='eza -lah --icons=auto --git'
alias ..='cd ..'
alias ...='cd ../..'
mkcd() { mkdir -p "$@" && cd "$@" || return; }
