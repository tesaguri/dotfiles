main() {
	unset -f main

	local f=

	for f in "$ZDOTDIR"/{.zshrc,zshrc.d/*.sh}; do
		{ [ ! -e "$f.zwc" ] || [[ "$f" -nt "$f.zwc" ]]; } && zcompile "$f"
	done

	for f in "$ZDOTDIR"/zshrc.d/*.sh; do
		# shellcheck disable=SC1090
		. "$f"
	done
}

main "$@"
