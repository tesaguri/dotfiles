main() {
	unset -f main

	if [ "$RCM_HOOK" = 1 ]; then
		return
	fi

	export HISTFILE="${XDG_DATA_HOME:-${HOME}/.local/share/zsh}/history"
	mkdir -p "$(dirname "$HISTFILE")"
	export HISTSIZE=100000
	export SAVEHIST=10000000
	setopt extended_history

	bindkey -e

	fpath=("$ZDOTDIR/functions" "${fpath[@]}")
	fpath+=(~/.zfunc)
	export fpath

	autoload -Uz compinit
	local zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
	mkdir -p "$(dirname "$zcompdump")"
	compinit -d "$zcompdump"

	export PROMPT='%0(?.%F{green}✔.%130(?.%F{yellow}⚠[%?].%F{red}✘[%?]))%f%n@%m%# '
	export RPROMPT=%~
}

main "$@"
