Minimal, fast terminal setup:

* **Zsh** + **Starship** (clean grey palette, newline `@`)
* **tmux** with a matching grey theme (truecolor)
* No symlinks required — copy files into place and go

> Tested on Linux & macOS. tmux ≥ 3.2 recommended.

---

## Folder layout

```
dotfiles/
├─ zsh/
│  └─ .zshrc
├─ tmux/
│  ├─ tmux.conf
│  └─ theme-grey.conf
└─ starship/
   └─ starship.toml
```

---

## What this setup looks like

* **Prompt (Starship)**
  Left: current dir + git branch → thin grey divider → Right: `py vX.Y.Z` (when in a Python project) + time → newline with green `@`.

* **tmux**
  Black/grey status bar. Active tab = slightly lighter grey. Truecolor on. No stray `10;rgb:` / `11;rgb:` lines.

* **Prefix & keys (tmux)**

  * Prefix: **backtick** `` ` ``
  * Panes: `w/a/s/d` to move, **Shift** `W/A/S/D` to resize
  * Splits: `h` (horiz) · `v` or `-` (vert) · `|` (horiz)
  * Zoom: `f` · Detach: `q` · Choose window: `e`
  * Windows: `Alt+1..9` · Next/Prev: `Ctrl-Tab` / `Ctrl-Shift-Tab`

---

## Prerequisites

Install with your package manager:

```bash
# Arch
sudo pacman -S zsh tmux starship eza ripgrep fzf zoxide

# Debian/Ubuntu
sudo apt install zsh tmux starship eza ripgrep fzf zoxide

# macOS
brew install zsh tmux starship eza ripgrep fzf zoxide
```

---

## Install (apply repo → local machine)

Copy files into standard locations (no symlinks):

```bash
# Zsh
install -Dm644 zsh/.zshrc                     ~/.zshrc

# Starship
install -Dm644 starship/starship.toml         ~/.config/starship.toml

# tmux (theme + main) + root shim
install -Dm644 tmux/tmux.conf                 ~/.config/tmux/tmux.conf
install -Dm644 tmux/theme-grey.conf           ~/.config/tmux/theme-grey.conf
printf 'source-file "~/.config/tmux/tmux.conf"\n' > ~/.tmux.conf
```

Reload:

```bash
exec zsh
tmux kill-server 2>/dev/null; tmux
```

---

## Update (sync your current machine → repo)

```bash
cp -f ~/.zshrc                                zsh/.zshrc
cp -f ~/.config/starship.toml                 starship/starship.toml
cp -f ~/.config/tmux/tmux.conf                tmux/tmux.conf
cp -f ~/.config/tmux/theme-grey.conf          tmux/theme-grey.conf
git add -A && git commit -m "Sync local configs" && git push
```

---

## Verify

```bash
# Starship is active
starship explain | head

# tmux is reading the right files
tmux display -p '#{config_files}'  # expect: ~/.tmux.conf, ~/.config/tmux/tmux.conf

# Grey theme styles
tmux show -g status-style                 # fg=#c8c093,bg=#020202
tmux show -g pane-active-border-style     # fg=#7e9cd8
tmux show -gw window-status-current-style # fg=#0a0a0a,bg=#3a3a3a,bold (or your chosen grey)
```

TERM values:

* **Inside tmux:** `echo $TERM` → `tmux-256color`
* **Outside tmux:** usually `xterm-256color`

---

## Notes & tweaks

* Starship is enabled at the end of `.zshrc` via:

  ```zsh
  eval "$(starship init zsh)"
  ```

* The `python` module shows in Python contexts (project files/venv).
  To force it everywhere: `touch ~/.python-version`.

* Change active tmux tab brightness: edit `~/.config/tmux/theme-grey.conf`

  ```tmux
  set -g window-status-current-style "fg=#0a0a0a,bg=#3a3a3a,bold"  # try #2a2a2a, #444444, etc.
  ```

---

## Troubleshooting

**I see `10;rgb:...` or `11;rgb:...` lines in the prompt**
Ensure in `~/.config/tmux/tmux.conf`:

```tmux
set -ga terminal-overrides ',*:Tc'  # truecolor
set -g allow-rename off
set -g allow-passthrough off
```

Then reload: `tmux source-file ~/.tmux.conf`.

**Prompt doesn’t look right**

* Remove Powerlevel10k lines if any.
* Make sure `~/.config/starship.toml` exists and you reloaded zsh (`exec zsh`).

