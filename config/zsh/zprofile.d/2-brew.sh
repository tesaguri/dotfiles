if [ -x /opt/homebrew/bin/brew ]; then
	eval "$(/opt/homebrew/bin/brew shellenv zsh)"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
elif [ -x /usr/local/bin/brew ]; then
	eval "$(/usr/local/bin/brew shellenv zsh)"
fi

if [ -n "$HOMEBREW_PREFIX" ] && [ -e "$HOMEBREW_PREFIX/opt/rustup" ]; then
	export PATH="$HOMEBREW_PREFIX/opt/rustup/bin:$PATH"
fi
