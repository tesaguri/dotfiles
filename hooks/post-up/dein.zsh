#!/usr/bin/env zsh

# shellcheck disable=SC1090
. "$(dirname "$0")/../../config/zsh/.zprofile" "$@"

function() {
	local dein_repo
	dein_repo="${XDG_DATA_HOME:-$HOME/.local/share}/dein/repos/github.com/Shougo/dein.vim"
	if ! [ -d "$dein_repo" ]; then
		mkdir -p "$(dirname "$dein_repo")"
		git clone 'https://github.com/Shougo/dein.vim.git' "$dein_repo"
		nvim --headless -c 'try | call dein#install() | finally | qall | endtry'
	fi
}
