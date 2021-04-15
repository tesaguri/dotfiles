export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"

gpgconf --launch gpg-agent

alias ssh='gpg-connect-agent updatestartuptty /bye > /dev/null && ssh "$@"'
alias scp='gpg-connect-agent updatestartuptty /bye > /dev/null && scp "$@"'
