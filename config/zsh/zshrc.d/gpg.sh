GPG_TTY="$(tty)"
export GPG_TTY
SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
export SSH_AUTH_SOCK

gpgconf --launch gpg-agent

eval "ssh() { gpg-connect-agent updatestartuptty /bye > /dev/null && $(command -pv ssh) \"\$@\"; }"
eval "scp() { gpg-connect-agent updatestartuptty /bye > /dev/null && $(command -pv scp) \"\$@\"; }"
