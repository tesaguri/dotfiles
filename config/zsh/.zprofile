function() {
	local f=

	if [ "$RCM_HOOK" -ne 1 ]; then
		for f in "$ZDOTDIR"/{.zprofile,zprofile.d/*.sh}; do
			{ [ ! -e "$f.zwc" ] || [[ "$f" -nt "$f.zwc" ]]; } && zcompile "$f"
		done
	fi

	for f in "$ZDOTDIR"/zprofile.d/*.sh; do
		# shellcheck disable=SC1090
		. "$f"
	done
}
