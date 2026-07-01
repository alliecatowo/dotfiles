# Fedora branch — live dotfiles snapshot (2026-07-01)

Snapshot of the current **Fedora Workstation** dotfiles, captured for the clean reinstall.
Refreshed packages: zsh, bash, git, ghostty, mise, starship, neofetch, nvim (LazyVim).

## Known cruft to clean (from the migration audit — see ~/Documents/migration/11-cruft-and-rot.md)
- **`.zshrc` PATH is assembled 3×** — `~/.local/bin` prepended in the mise block, again as a
  bare line, and again by the "Antigravity CLI installer" line. Dedupe to ONE prepend.
- **`.zshrc` is a reconstruction** (original lost 2025-10-03; header says so). Good moment to
  rewrite it clean and single-source the PATH.
- **Dead PATH dirs** referenced live: `~/.opencode/bin` (twice, doesn't exist) + 7
  `~/.claude/plugins/cache/.../bin` dirs. Remove.
- Same installer PATH blocks are duplicated across `.zshrc`, `.bashrc`, `.bash_profile`.
- **README still says "KDE Plasma"** — you're on GNOME now; update it.
- `konsole/` package is KDE (Dracula.colorscheme) — drop if not using Konsole on GNOME.

## Restore
`stow` each package as before. Do NOT carry the KDE `~/.config/gtk-3.0|4.0/settings.ini`
overrides forward (they fight GNOME scaling — see the audit).
