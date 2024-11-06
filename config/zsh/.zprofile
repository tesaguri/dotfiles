if [ -e "$HOME/.profile" ]; then
	. "$HOME/.profile"
fi

function() {
	local f=

	for f in "$ZDOTDIR"/zprofile.d/*.zsh; do
		# shellcheck disable=SC1090
		. "$f"
	done
}
