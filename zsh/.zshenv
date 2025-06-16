# ~/.zshenv - Always sourced, should be minimal
# This file is sourced for ALL zsh instances (login, interactive, scripts)

# Skip global compinit for faster startup
skip_global_compinit=1

# Set ZDOTDIR to organize zsh files (optional)
# export ZDOTDIR="$HOME/.config/zsh"

# Essential environment variables only
export EDITOR="vim"
export VISUAL="$EDITOR"
export PAGER="less"

# Skip system-wide setup if we're in ghostty
if [[ "$TERM_PROGRAM" == "Ghostty" ]]; then
    # Skip the system rc file
    setopt NO_GLOBAL_RCS
    
    # Set essential options
    setopt COMBINING_CHARS
    disable log
    
    # History setup
    HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
    HISTSIZE=2000
    SAVEHIST=1000
fi

