if ! command -v gpgconf > /dev/null; then
	return
fi

GPG_TTY="${TTY:-$(tty)}"
export GPG_TTY
SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
export SSH_AUTH_SOCK

if gpgconf --launch gpg-agent 2> /dev/null; then
	eval "ssh() { gpg-connect-agent updatestartuptty /bye > /dev/null && $(whence -p ssh) \"\$@\"; }"
	eval "scp() { gpg-connect-agent updatestartuptty /bye > /dev/null && $(whence -p scp) \"\$@\"; }"
fi
