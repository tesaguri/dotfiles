if ! [[ "$PATH" == */usr/local/sbin* ]]; then
	PATH="/usr/local/sbin:$PATH" # `brew doctor` wants it.
fi
PATH="${XDG_BIN_HOME:-$HOME/.local/bin}:$PATH"
export PATH
