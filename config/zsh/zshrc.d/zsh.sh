function() {
	export HISTFILE="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/history"
	mkdir -p "$(dirname "$HISTFILE")"
	export HISTSIZE=100000
	export SAVEHIST=10000000
	setopt extended_history

	bindkey -e

	# Display exit status and optional signal name in `PROMPT`:
	local prompt_signal signal_name exit_status=$((128 + 31))
	for signal_name in \
		USR2 \
		USR1 \
		INFO \
		WINCH \
		PROF \
		VTALRM \
		XFSZ \
		XCPU \
		IO \
		TTOU \
		TTIN \
		CHLD \
		CONT \
		TSTP \
		STOP \
		URG \
		TERM \
		ALRM \
		PIPE \
		SYS \
		SEGV \
		BUS \
		KILL \
		FPE \
		EMT \
		ABRT \
		TRAP \
		ILL \
		QUIT \
		INT \
		HUP
	do
		prompt_signal="%$exit_status(?.($signal_name).$prompt_signal)"
		exit_status=$((exit_status - 1))
	done
	export PROMPT="%(?.%F{green}0.%F{red}%?$prompt_signal)%f:%n@%m%# "

	# Show working directory in grey color.
	export RPROMPT='%F{242}%~'
}
