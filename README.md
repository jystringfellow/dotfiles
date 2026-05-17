# Dotfiles

My personal Git, shell, and system configuration files for macOS.  
Designed for **easy setup on new machines** and safe separation of personal vs. professional settings.

---

## Repository Structure

```text
dotfiles/
├── git/
│   ├── gitconfig         # Base Git config (tracked)
│   ├── aliases           # Git aliases (tracked)
│   └── gitconfig.local   # Machine/work-specific overrides (untracked)
└── zsh/
    ├── zshrc             # Main zsh config (tracked)
    ├── aliases           # Shell aliases (tracked)
    └── zshrc.local       # Machine-specific overrides (untracked)
```

> Symlink `~/.gitconfig` to `git/gitconfig` and `~/.zshrc` to `zsh/zshrc` for full setup.

---

## Setup on a New Machine

### Quick Setup (Recommended)

1. **Clone and run the setup script**

   ```sh
   git clone https://github.com/jystringfellow/dotfiles.git
   cd dotfiles
   ./setup.sh
   ```

The script will automatically create symlinks, back up existing configs, and verify everything loads correctly.

### Manual Setup

If you prefer to set things up manually:

1. **Clone the repository and jump to the repo directory**

   ```sh
   git clone https://github.com/jystringfellow/dotfiles.git
   cd dotfiles
   ```

2. **Automatically detect location and set up symlinks**

   ```sh
   export DOTFILES_REPO=$(pwd)
   
   # Git
   ln -s $DOTFILES_REPO/git/gitconfig ~/.gitconfig
   ln -s $DOTFILES_REPO/git/aliases ~/.git-aliases
   
   # Zsh
   ln -s $DOTFILES_REPO/zsh/zshrc ~/.zshrc
   ln -s $DOTFILES_REPO/zsh/aliases ~/.zsh-aliases
   ```

3. **Create local config files for machine-specific settings**

   ```sh
   touch $DOTFILES_REPO/git/gitconfig.local
   touch $DOTFILES_REPO/zsh/zshrc.local
   
   # Symlink local configs (optional, for convenience)
   ln -s $DOTFILES_REPO/git/gitconfig.local ~/.gitconfig.local
   ln -s $DOTFILES_REPO/zsh/zshrc.local ~/.zshrc.local
   ```

4. **Ensure GitHub CLI is installed** for `pr` and `open` aliases

   ```sh
   brew install gh
   gh auth login
   ```

---

## Git Config Highlights

- `pull.rebase = true` — linear history by default
- `rebase.autoStash = true` — no conflicts with unstaged changes during rebase
- `fetch.prune = true` — remove deleted remote branches automatically
- `credential.helper = osxkeychain` — macOS credential storage
- Git aliases sourced from `~/.git-aliases` (symlinked, repository-location independent)
- Machine-specific overrides in `~/.gitconfig.local` (symlinked, untracked)

---

## Zsh Config Highlights

- Prompt powered by [posh-git-sh](https://github.com/lyze/posh-git-sh) — shows branch and status inline
- Zsh completion system enabled via `compinit`
- Shell aliases sourced from `~/.zsh-aliases` (symlinked, repository-location independent)
- Machine-specific overrides in `~/.zshrc.local` (symlinked, untracked, gitignored)

---

## Aliases

Some of the most useful aliases included:

| Alias      | Command                          | Description                    |
|------------|----------------------------------|--------------------------------|
| `graph`    | `git log --graph ...`            | Pretty commit graph            |
| `ls`       | `git log ...`                    | Detailed commit list           |
| `who`      | `git shortlog -n -s --no-merges` | Contributors summary           |
| `s` / `ss` | `status` / `status -sb`          | Short / detailed status        |
| `cm` / `ca`| `commit -m` / `commit --amend`   | Commit shorthand               |
| `sw` / `swc`| `switch` / `switch -c`          | Modern checkout commands       |
| `cleanbr`  | Remove merged branches safely    | Cleanup old branches           |
| `pr`       | `gh pr create --web`             | Open GitHub PR in browser      |
| `open`     | Open current branch in GitHub    | Quick web link                 |

See [git/aliases](git/aliases) for the full list.

---

## Why Symlink Everything?

By symlinking **all** config files (not just the main `gitconfig` and `zshrc`), your configuration files remain **independent of the repository location**. This means:

- If you clone to `/Volumes/Craig/Code/dotfiles` or `~/Code/dotfiles`, everything still works without changes
- Your `gitconfig` and `zshrc` don't need hardcoded paths to the repository
- Adding new machines or reorganizing directories doesn't require updates to config files
- Clean separation of concerns: `gitconfig`/`zshrc` source from home directory symlinks, which point to the repository

---

## Personal vs Professional Usage

- **Base configs** — safe for all machines and repositories
- **`gitconfig.local`** / **`zshrc.local`** — machine- or work-specific overrides (never tracked)
- Supports multiple Git identities via `includeIf` for personal vs. work directories

---

## Contributing

This repo is mostly for personal use, but feel free to fork or adapt.  
Keep `gitconfig.local` and `zshrc.local` untracked for sensitive data.

---

## License

MIT License © Jacob Stringfellow