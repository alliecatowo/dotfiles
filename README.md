# dotfiles

My personal macOS and Fedora setup, driven entirely by [mise](https://mise.jdx.dev).
One `mise bootstrap` run installs apps, clones my repos, deploys dotfiles, applies macOS settings,
installs every dev tool, and finishes the GitHub, SSH and Claude Code setup.

This repo is **public and personal-only**. Nothing work-related goes in it, and neither do secrets.
Secrets live in a private overlay (see [Secrets](#secrets)).

## New machine

```sh
curl -fsSL https://raw.githubusercontent.com/alliecatowo/dotfiles/main/install.sh | sh -s -- --dry-run   # preview
curl -fsSL https://raw.githubusercontent.com/alliecatowo/dotfiles/main/install.sh | sh
```

`install.sh` installs Xcode Command Line Tools if needed (re-run once it finishes) and mise from mise.run.
It clones this repo to `~/Develop/dotfiles` and links `~/.config/mise` to `config/mise/`.
Then it runs `mise bootstrap`, in this order:

| Step | Source |
|---|---|
| Apps (casks, App Store, dnf, flatpak) | `config/mise/conf.d/10-packages.toml` |
| Repos (antidote, my active projects) | `config/mise/conf.d/40-repos.toml` |
| Dotfiles | `config/mise/conf.d/20-dotfiles.toml` and `home/` |
| macOS Dock, keyboard, trackpad, login items | `config/mise/conf.d/30-macos.toml` |
| Dev tools and runtimes | `[tools]` in `config/mise/config.toml` |
| GitHub login, SSH keys, private repos, Claude plugins, Tailscale | `config/mise/tasks/bootstrap` |

Every step is idempotent, so re-run `mise bootstrap` at any time. Run it a second time on a fresh Mac,
because App Store apps are skipped until `mas` exists.

### Manual steps (these can't be automated)

1. Sign in to the App Store, then re-run `mise bootstrap` to install App Store apps.
2. When `setup:github` opens a browser, log in to GitHub.
3. Set a passphrase when `setup:ssh` creates the keys.
4. Log in to Tailscale from its menu bar icon. On Fedora, `setup:tailscale` prints a login URL.
5. Log in to Bitwarden, then run `mise run setup:secrets` and paste the age identity from the
   "age identity (dotfiles)" note.
6. Log in to Chrome with my personal Google account. That brings Gmail, bookmarks and extensions with it.
7. Log in to Discord, Spotify, Claude Desktop and Raycast. Raycast settings come from Cloud Sync,
   or from **Import Settings** with an `.rayconfig` export.
8. Rectangle Pro: enter the license key, then turn on iCloud sync or use **Import** with an exported config.

## Day to day

| Task | Command |
|---|---|
| See what would change | `mise bootstrap plan` |
| Check this machine is healthy | `mise run doctor` |
| Add a global tool | `mise use -g <tool>` (writes into this repo through the link) |
| Add an app | add a `brew-cask:` line to `10-packages.toml`, then `mise bootstrap --only packages` |
| See dotfile drift | `mise dot status` / `mise dot diff` |
| Pull in-place edits back into the repo | `mise dot add --changed` |
| Edit secrets | `mise run setup:secrets-edit` |

## Layout

```
install.sh              curl | sh entry point
config/mise/            becomes ~/.config/mise
  config.toml           settings and global [tools]
  conf.d/               packages, dotfiles, macOS, repos, secrets
  tasks/                global tasks: bootstrap, doctor, setup:*
home/<group>/           files laid out relative to ~ (Stow-compatible)
mise.toml               tasks for working on this repo: `mise run check` scans for secrets
```

Dotfiles use two modes. **symlink** suits files that nothing else rewrites: starship, ghostty, nvim,
`.bashrc`, `~/.config/git/config`. **copy** gives you a real file you can edit in place: `~/.zshrc`
and `~/.ssh/config`. Run `mise dot add --changed` to pull in-place edits back into the repo.

`~/.gitconfig` is deliberately a machine-local real file. `git config --global`, `gh` and `git-lfs`
write there, not through the symlink into this public repo.

Anything specific to one machine goes in untracked files that the tracked ones source:
`~/.zshrc.local`, `~/.bashrc.local`, `~/.ssh/config.local`, `~/.gitconfig`,
`~/.config/mise/config.local.toml`.

## Git identity and signing

The default identity is personal: the GitHub noreply email, with commits signed by this machine's own
SSH key (`~/.ssh/id_ed25519_signing`). `setup:ssh` creates separate auth and signing keys per machine
and registers both with GitHub. When a machine is retired, revoke its two keys and nothing else changes.

On a work machine, `~/.gitconfig` holds the work identity, and it loads after the shared config, so it
wins. To keep personal repos personal there, append this to the end of `~/.gitconfig`:

```ini
[includeIf "hasconfig:remote.*.url:git@github.com:alliecatowo/**"]
	path = ~/.config/git/personal
[includeIf "hasconfig:remote.*.url:https://github.com/alliecatowo/**"]
	path = ~/.config/git/personal
```

`~/.config/git/personal` holds only the personal `[user]` block, so the email and signing key always travel together.

## Secrets

Secrets live in **`alliecatowo/dotfiles-private`**, a private repo cloned to
`~/.local/share/dotfiles-private`. It holds sops files encrypted to two age keys: a primary and an
offline recovery key. mise decrypts them itself (`conf.d/50-secrets.toml`) and exports them as env vars.
The age identity is backed up as a Bitwarden note.

- Even the encrypted files stay out of this public repo, so a leaked key can't decrypt anything
  published here.
- GitHub Actions secrets can't be read back to a laptop, so they're no use as a vault.
- Personal secrets only. Employer-owned credentials never go in either repo.

## Linux (Fedora, GNOME)

The same bootstrap works on Fedora. The `brew-cask:` and `mas:` entries are skipped, and the `dnf:` and
`flatpak:` entries apply instead. `setup:tailscale` adds the Tailscale repo and enables `tailscaled`.
