function() {
	if [ "$RCM_HOOK" = 1 ]; then
		return
	fi

	export HISTFILE="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/history"
	mkdir -p "$(dirname "$HISTFILE")"
	export HISTSIZE=100000
	export SAVEHIST=10000000
	setopt extended_history

	bindkey -e

	export PROMPT='%0(?.%F{green}✔.%130(?.%F{yellow}⚠[%?].%F{red}✘[%?]))%f%n@%m%# '
	export RPROMPT=%~
}
