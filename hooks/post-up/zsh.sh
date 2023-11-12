#!/usr/bin/env zsh

(
	setopt dotglob nullglob
	zwc=("$HOME"/*.zwc "$ZDOTDIR"/**/*.zwc)
	if ((${#zwc})); then
		rm -f -- "${zwc[@]}"
	fi
)

for f in "$HOME/.zshenv" "$ZDOTDIR"/{.zprofile,zprofile.d/*.sh,.zshrc,zshrc.d/*.sh}; do
	zcompile "$f"
done
