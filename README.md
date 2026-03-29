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

1. **Clone the repo**

   ```sh
   git clone https://github.com/jystringfellow/dotfiles.git ~/Code/dotfiles
   ```

2. **Symlink your Git config**

   ```sh
   ln -s ~/Code/dotfiles/git/gitconfig ~/.gitconfig
   ```

3. **Symlink your zsh config**

   ```sh
   ln -s ~/Code/dotfiles/zsh/zshrc ~/.zshrc
   ```

4. **Optional:** create local configs for machine-specific settings

   ```sh
   touch ~/Code/dotfiles/git/gitconfig.local
   touch ~/Code/dotfiles/zsh/zshrc.local
   ```

5. **Ensure GitHub CLI is installed** for `pr` and `open` aliases

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
- Separate `aliases` and `gitconfig.local` for maintainability

---

## Zsh Config Highlights

- Prompt powered by [posh-git-sh](https://github.com/lyze/posh-git-sh) — shows branch and status inline
- Zsh completion system enabled via `compinit`
- Shell aliases sourced from `zsh/aliases` (tracked)
- Machine-specific overrides in `zsh/zshrc.local` (untracked, gitignored)

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