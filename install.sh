#!/bin/sh
# Fresh-machine bootstrap:
#   curl -fsSL https://raw.githubusercontent.com/alliecatowo/dotfiles/main/install.sh | sh
# Another branch: DOTFILES_REF=<branch> (and fetch install.sh from that branch too).
# Installs mise, clones this repo to ~/Develop/dotfiles, links ~/.config/mise to config/mise,
# then runs `mise bootstrap`. Extra args go to `mise bootstrap` (try --dry-run first).
set -eu

repo="${DOTFILES_REPO:-https://github.com/alliecatowo/dotfiles.git}"
dir="${DOTFILES_DIR:-$HOME/Develop/dotfiles}"
ref="${DOTFILES_REF:-main}"

if [ "$(uname -s)" = Darwin ] && ! xcode-select -p >/dev/null 2>&1; then
  # git and a compiler come with the Command Line Tools. The installer is a GUI dialog.
  xcode-select --install || true
  echo "Finish the Command Line Tools install, then re-run this script."
  exit 1
fi

# mise.run, not Homebrew: one install method everywhere, and it can self-update.
# /opt/homebrew/bin too, so formulae mise pours early in the run (mas) are usable later in the same run.
export PATH="$HOME/.local/bin:/opt/homebrew/bin:$PATH"
command -v mise >/dev/null 2>&1 || curl -fsSL https://mise.run | sh

if [ -e "$HOME/.config/mise" ] && [ ! -L "$HOME/.config/mise" ]; then
  backup="$HOME/.config/mise.pre-dotfiles.$(date +%Y%m%d%H%M%S)"
  echo "Moving existing ~/.config/mise to $backup"
  mv "$HOME/.config/mise" "$backup"
fi

mise bootstrap --from "$repo?ref=$ref" --from-dir "$dir" --config-dir config/mise "$@"
