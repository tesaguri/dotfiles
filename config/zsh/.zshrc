function() {
	local f=

	for f in "$ZDOTDIR"/zshrc.d/*.zsh; do
		# shellcheck disable=SC1090
		. "$f"
	done
}
