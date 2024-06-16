if [ -e "$HOME/.profile" ]; then
	. "$HOME/.profile"
fi

function() {
	local f=

	for f in "$ZDOTDIR"/zprofile.d/*.sh; do
		# shellcheck disable=SC1090
		. "$f"
	done
}
