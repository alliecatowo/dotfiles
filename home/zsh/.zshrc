# ~/.zshrc: deployed by `mise dot apply` in copy mode, so this is a real file.
# Edit it here or in place, then run `mise dot add --changed` to copy edits back to the repo.
# Machine-specific additions go in ~/.zshrc.local, which is never tracked.

# ── PATH ──────────────────────────────────────────────────────
typeset -U path PATH
# mise installs formulae into the Homebrew prefix without a `brew` binary, so key off the directory.
if [[ -x /opt/homebrew/bin/brew ]]; then eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -d /opt/homebrew/bin ]]; then path=(/opt/homebrew/bin /opt/homebrew/sbin $path); fi
path=("$HOME/.local/bin" $path)

# ── mise (after every PATH edit, before anything that needs its tools) ──
eval "$(mise activate zsh)"

# ── History ───────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt share_history hist_ignore_all_dups hist_find_no_dups hist_reduce_blanks \
       hist_verify inc_append_history extended_history

# ── Plugins (antidote is cloned by `mise bootstrap` into ~/.antidote) ──
# antidote first so plugins extend fpath, then compinit.
source ~/.antidote/antidote.zsh
antidote load ~/.zsh_plugins.txt
autoload -Uz compinit && compinit -C

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ── Key bindings ──────────────────────────────────────────────
bindkey '^ ' autosuggest-accept
bindkey '^[[1;5C' forward-word;  bindkey '^[[1;5D' backward-word   # Ctrl+arrows
bindkey '^[[1;3C' forward-word;  bindkey '^[[1;3D' backward-word   # Alt+arrows
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ── Prompt and navigation ─────────────────────────────────────
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
source <(fzf --zsh)

# ── Aliases ───────────────────────────────────────────────────
alias sudo='sudo '
alias ls='eza --icons=auto'
alias ll='eza -lah --icons=auto --git'
alias la='eza -a'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mr='mise run'
alias mi='mise install'
alias mu='mise use'
mkcd() { mkdir -p "$@" && cd "$@" || return; }

export EDITOR=nvim
export ZVEC_GREP_EMBEDDING="local/potion-code-16m-v2"

[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
