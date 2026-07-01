# Reconstructed .zshrc from running session
# Recovered on 2025-10-03

# History configuration
export HISTSIZE=10000
export HISTCONTROL=ignoredups

# Mise activation
eval "$(~/.local/bin/mise activate zsh)"

# Antidote plugin manager
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load ${ZDOTDIR:-~}/.zsh_plugins.txt

# Starship prompt
eval "$(starship init zsh)"

# Zoxide (smart cd)
eval "$(zoxide init zsh)"


# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/Allie/.lmstudio/bin"
# End of LM Studio CLI section

export PATH="$HOME/.local/bin:$PATH"

# opencode
export PATH=/home/Allie/.opencode/bin:$PATH

# Added by flyctl installer
export FLYCTL_INSTALL="/home/Allie/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# Keep color enabled
unset NO_COLOR


# Added by Antigravity CLI installer
export PATH="/home/Allie/.local/bin:$PATH"
