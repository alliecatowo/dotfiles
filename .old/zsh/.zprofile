ANTIDOTE_HOME="$HOME/.config/zsh"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add Homebrew Python to the PATH
export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"


export CLICOLOR=1
export HOMEBREW_COLOR=1
export GREP_OPTIONS='--color=auto'
export FZF_DEFAULT_COMMAND='fd --type f'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESS='-R'
export BAT_THEME="Dracula"

# Created by `pipx` on 2025-02-14 03:34:25
export PATH="$PATH:/Users/allison/.local/bin"

source "$HOME/.zaliases"
