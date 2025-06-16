# Skip global compinit
skip_global_compinit=1

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

