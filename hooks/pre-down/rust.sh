#!/bin/sh

if [ -L "$CARGO_INSTALL_ROOT/bin/rustup" ]; then
	rm "$CARGO_INSTALL_ROOT/bin/rustup"
fi
