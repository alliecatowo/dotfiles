# ── ASDF Setup (must be early) ──────────────────────────────────
. /opt/homebrew/opt/asdf/libexec/asdf.sh
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

# ── Antidote Setup ───────────────────────────────────────────────
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

fpath=(/opt/homebrew/share/antidote/functions $fpath)
autoload -Uz antidote
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >! ${zsh_plugins}.zsh
fi

# ── Completion Setup ─────────────────────────────────────────────
autoload -Uz compinit colors
compinit -C
colors
source ~/.zsh_plugins.zsh

export LS_COLORS="$(vivid generate dracula 2>/dev/null || gdircolors -b)"

# fzf-tab-specific styles

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' continuous-trigger '/'
zstyle ':fzf-tab:*' prefix ''
zstyle ':fzf-tab:*' switch-group ',' '.'

# In .zshrc
[[ -o interactive ]] || return

# Then AFTER Antidote loads plugins and fzf-tab is sourced
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-preview '
  mimetype=$(file --mime-type -b "$realpath")
  printf "\\033_Ga=d,i=1337;\\033\\\\"
  if [ -d "$realpath" ]; then
    lsd --color=always --icon=always --long --date=relative --header \
        --blocks name,size,date --group-dirs=first "$realpath"
  elif [[ "$realpath" == *.json ]]; then
    bat --language=json --style=numbers --color=always --line-range :500 "$realpath"
  elif [[ "$realpath" == *.pdf ]]; then
    pdftotext "$realpath" - | head -n 100
  elif [[ "$mimetype" == image/* ]]; then
    chafa --format=kitty --size=40x20 "$realpath" \
      | sed "s/^/\\033_Gf=100,a=T,t=d,i=1337;/" \
      | sed "s/\$/\\033\\\\/"
  elif [[ "$mimetype" == video/* || "$mimetype" == audio/* ]]; then
    echo "$realpath"
    echo "---"
    ffprobe -v error -show_entries format=duration:format_tags=title:format_tags=comment \
      -of default=noprint_wrappers=1:nokey=0 "$realpath" 2>/dev/null | head -n 20
  elif [ -f "$realpath" ] && bat --color=always --plain "$realpath" >/dev/null 2>&1; then
    bat --style=numbers --color=always --line-range :500 "$realpath"
  elif [[ "$LBUFFER" =~ "^([[:alnum:]_-]+)( +([[:alnum:]_-]+))?" ]]; then
    cmd1=${match[1]}
    cmd2=${match[3]}
    if command -v "$cmd1" >/dev/null; then
      "$cmd1" $cmd2 --help 2>&1 | head -n 50 || man "$cmd1-$cmd2" | col -bx | head -n 50
    fi
  elif command -v "$word" >/dev/null; then
    "$word" --help 2>&1 | head -n 50 || man "$word" | col -bx | head -n 50
  else
    file "$realpath"
  fi
'

# ── Bindings ───────────────────────────────────────────────────
bindkey '^ ' autosuggest-accept
bindkey '^R' fzf-history-widget
# ── Tool Initialization ──────────────────────────────────────────
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
# Use asdf-direnv instead of plain direnv for better asdf integration
eval "$(asdf exec direnv hook zsh)"

# Clean up PATH by removing old version managers and redundant entries
export PATH=$(echo $PATH | tr ':' '\n' | grep -v '/opt/homebrew/opt/python' | grep -v 'fnm' | grep -v 'nvm' | sort -u | tr '\n' ':' | sed 's/:$//')

# ── Path Setup ────────────────────────────────────────────────────
# Ensure asdf shims come first for tool version management, then Homebrew
export PATH="$HOME/.asdf/shims:/opt/homebrew/bin:$PATH"
export PATH="$PATH:/Users/allison/Library/Application\ Support/google-cloud-sdk/bin"
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
