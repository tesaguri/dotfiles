function() {
	local f=

	for f in "$ZDOTDIR"/zshrc.d/*.sh; do
		# shellcheck disable=SC1090
		. "$f"
	done
}
