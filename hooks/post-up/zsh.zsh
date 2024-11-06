#!/usr/bin/env zsh

(
	setopt dotglob nullglob
	zwc=("$HOME"/*.zwc "$ZDOTDIR"/**/*.zwc)
	if ((${#zwc})); then
		rm -f -- "${zwc[@]}"
	fi
)

for f in "$HOME/.zshenv" "$ZDOTDIR"/{.zprofile,zprofile.d/*.zsh,.zshrc,zshrc.d/*.zsh}; do
	zcompile "$f"
done
