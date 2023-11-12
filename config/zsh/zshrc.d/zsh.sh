function() {
	export HISTFILE="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/history"
	mkdir -p "$(dirname "$HISTFILE")"
	export HISTSIZE=100000
	export SAVEHIST=10000000
	setopt extended_history

	bindkey -e

	export PROMPT='%0(?.%F{green}✔.%130(?.%F{yellow}⚠[%?].%F{red}✘[%?]))%f%n@%m%# '
	# Show working directory in grey color.
	export RPROMPT='%F{242}%~'
}
