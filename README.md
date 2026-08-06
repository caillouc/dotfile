# Dotfiles

Personal dotfiles and desktop settings for Linux, with a few shared shell and editor configs.

## What is here

- `init.vim` for Vim and Neovim
- `terminal/profile.zsh` and `terminal/nice.zsh-theme` for shell setup
- `vscode/settings.json` and `vscode/keybindings.json` for VS Code
- `dconf-settings.ini` for GNOME desktop settings on Linux
- `archive/` for older or platform-specific configs

## Install

Run the installer from the repo root:

```bash
./install.sh
```

It creates the main symlinks in your home directory and writes a basic `~/.zshrc` that points to this repo.

## dconf settings

To apply the saved GNOME settings from this repo:

```bash
dconf load / < dconf-settings.ini
```

To save your current GNOME settings back into this file after making changes:

```bash
dconf dump / > dconf-settings.ini
```

The `dconf` commands are meant for Linux/GNOME only.
