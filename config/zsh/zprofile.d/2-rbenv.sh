RBENV_ROOT="$(whence -p rbenv)" &&
export RBENV_ROOT="${RBENV_ROOT%/*/*}/var/rbenv" &&
eval "$(rbenv init -)"
