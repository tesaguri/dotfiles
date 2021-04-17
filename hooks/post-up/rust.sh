if [ ! -e "$CARGO_INSTALL_ROOT/rustup" ] || [ -L "$CARGO_INSTALL_ROOT/rustup" ]; then
	ln -fs "$CARGO_HOME/bin/rustup" "$CARGO_INSTALL_ROOT/rustup"
fi
