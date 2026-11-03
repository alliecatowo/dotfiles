#!/bin/sh
# Fresh-machine bootstrap:
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/alliecatowo/dotfiles/main/install.sh)"
# Another branch: DOTFILES_REF=<branch> (and fetch install.sh from that branch too).
# Installs mise, clones this repo to ~/Develop/dotfiles, links ~/.config/mise to config/mise,
# then runs `mise bootstrap`. Extra args go to `mise bootstrap`.
set -eu

repo="${DOTFILES_REPO:-https://github.com/alliecatowo/dotfiles.git}"
dir="${DOTFILES_DIR:-$HOME/Develop/dotfiles}"
ref="${DOTFILES_REF:-main}"
min_mise="2026.10.25"

dry_run=false
for arg in "$@"; do
  case "$arg" in --dry-run|-n) dry_run=true ;; esac
done

# If piped (`curl | sh`), give prompts (gh login, ssh-keygen, sudo) the terminal instead of the pipe.
[ -t 0 ] || exec </dev/tty

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

have="$(mise --version | cut -d' ' -f1)"
if [ "$(printf '%s\n%s\n' "$min_mise" "$have" | sort -V | head -1)" != "$min_mise" ]; then
  echo "mise $have is older than $min_mise. Upgrade it the way it was installed, then re-run."
  exit 1
fi

if $dry_run; then
  # Without a checkout there's nothing to preview beyond the clone. After the first real run,
  # `mise bootstrap --dry-run` or `mise bootstrap plan` shows the full plan.
  exec mise bootstrap --from "$repo?ref=$ref" --from-dir "$dir" --config-dir config/mise "$@"
fi

if [ -e "$HOME/.config/mise" ] && [ ! -L "$HOME/.config/mise" ]; then
  backup="$HOME/.config/mise.pre-dotfiles.$(date +%Y%m%d%H%M%S)"
  echo "Moving existing ~/.config/mise to $backup"
  mv "$HOME/.config/mise" "$backup"
fi

# The Homebrew installer (pre-packages hook) runs non-interactively and needs cached sudo.
if [ "$(uname -s)" = Darwin ]; then sudo -v; fi

mise bootstrap --from "$repo?ref=$ref" --from-dir "$dir" --config-dir config/mise "$@"
