if ! command -v gpgconf > /dev/null; then
	return
fi

GPG_TTY="${TTY:-$(tty)}"
export GPG_TTY

# Use `gpg-agent` as an SSH agent. cf. EXAMPLES of `gpg-agent(1)`.
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)" &&
	export SSH_AUTH_SOCK
fi

if gpgconf --launch gpg-agent 2> /dev/null; then
	# Redefine `ssh` and `scp` commands to update TTY of the agent, if the commands exist and are
	# are not already overriden. cf. `--enable-ssh-support` in `gpg-agent(1)`.
	if command -v ssh > /dev/null && [ "$(command -v ssh)" = "$(whence -p ssh)" ]; then
		eval "ssh() { gpg-connect-agent updatestartuptty /bye > /dev/null && $(printf '%q' "$(whence -p ssh)") \"\$@\"; }"
	fi
	if command -v scp > /dev/null && [ "$(command -v scp)" = "$(whence -p scp)" ]; then
		eval "scp() { gpg-connect-agent updatestartuptty /bye > /dev/null && $(printf '%q' "$(whence -p scp)") \"\$@\"; }"
	fi
fi
