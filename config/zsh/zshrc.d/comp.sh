function() {
	local zfunc="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/site-functions"
	mkdir -p "$zfunc"
	fpath+=("$zfunc")

	_compgen() {
		if ! [[ "$zfunc/_$1" -nt "$(command -v "$1")" ]]; then
			"$@" > "$zfunc/_$1"
		fi
	}

	if type rustup > /dev/null 2>&1; then
		fpath+=("$(rustup show home)/toolchains/$(rustup default | cut -d' ' -f1)/share/zsh/site-functions")
		_compgen rustup completions zsh
	fi

	# Using `diesel_cli` from `cargo install` rather than the package manager to customize
	# the crate features, but Cargo won't install the shell completions for you.
	type diesel > /dev/null 2>&1 && _compgen diesel completions zsh

	unset -f _compgen
	export fpath

	autoload -Uz compinit
	local zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
	mkdir -p "$(dirname "$zcompdump")"
	compinit -d "$zcompdump"
}
