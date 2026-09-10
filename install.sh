#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
home_dir="${HOME:?}"

backup_path() {
	local path="$1"

	if [[ -e "$path" && ! -L "$path" ]]; then
		mv "$path" "${path}.bak.$(date +%Y%m%d%H%M%S)"
	fi
}

link_file() {
	local source="$1"
	local target="$2"

	mkdir -p "$(dirname "$target")"
	backup_path "$target"
	ln -sfn "$source" "$target"
}

write_zshrc() {
	local zshrc_path="$home_dir/.zshrc"

	backup_path "$zshrc_path"
	cat > "$zshrc_path" <<EOF
export DOTFILE_PATH="$repo_root"
export ZSH_PLUGIN_PATH="\${ZSH_PLUGIN_PATH:-$HOME/Documents/zsh-plugin}"
export JUMP_CMD_PATH="\${JUMP_CMD_PATH:-$HOME/Documents/jump-commands}"

if [[ -f "\$DOTFILE_PATH/terminal/profile.zsh" ]]; then
	source "\$DOTFILE_PATH/terminal/profile.zsh"
fi
EOF
}

main() {
	link_file "$repo_root/.gitconfig" "$home_dir/.gitconfig"
	link_file "$repo_root/init.vim" "$home_dir/.vimrc"
	link_file "$repo_root/init.vim" "$home_dir/.config/nvim/init.vim"
	link_file "$repo_root/vscode/settings.json" "$home_dir/.config/Code/User/settings.json"
	link_file "$repo_root/vscode/keybindings.json" "$home_dir/.config/Code/User/keybindings.json"
	link_file "$repo_root/zed/settings.json" "$home_dir/.config/zed/settings.json"
	link_file "$repo_root/zed/keymap.json" "$home_dir/.config/zed/keymap.json"
	write_zshrc

	# if [[ "$(uname -s)" == "Linux" ]] && command -v dconf >/dev/null 2>&1; then
	# 	dconf load / < "$repo_root/dconf-settings.ini"
	# fi
}

main "$@"
