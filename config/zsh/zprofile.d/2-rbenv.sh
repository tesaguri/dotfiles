if command -v rbenv >/dev/null; then
	export RBENV_ROOT=/usr/local/var/rbenv
	eval "$(rbenv init -)"
fi
