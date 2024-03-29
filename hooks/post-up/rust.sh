#!/usr/bin/env zsh

# shellcheck disable=SC1090
RCM_HOOK=1 . "$(dirname "$0")/../../config/zsh/.zprofile" "$@"

if [ ! -e "$CARGO_INSTALL_ROOT/bin/rustup" ] || [ -L "$CARGO_INSTALL_ROOT/bin/rustup" ]; then
	ln -fs "$CARGO_HOME/bin/rustup" "$CARGO_INSTALL_ROOT/bin/rustup"
fi
