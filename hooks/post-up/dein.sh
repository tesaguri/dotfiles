# shellcheck disable=SC1090
RCM_HOOK=1 . "$(dirname "$0")/../../config/zsh/.zprofile" "$@"

main() {
	unset -f main

	local dein_repo="${XDG_CACHE_HOME:-$HOME/.cache}/dein/repos/github.com/Shougo/dein.vim"
	if ! [ -d "$dein_repo" ]; then
		mkdir -p "$(dirname "$dein_repo")"
		git clone 'https://github.com/Shougo/dein.vim.git' "$dein_repo"
		nvim -c 'try | if dein#check_install() | call dein#install() | endif | finally | qall | endtry'
	fi
}

main "$@"
