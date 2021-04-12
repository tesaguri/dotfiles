() {
	local f=

	for f in "$ZDOTDIR"/{functions/*[^.zwc],.zshrc,zshrc.d/*.zsh}; do
		([ ! -e $f.zwc ] || [[ $f -nt $f.zwc ]]) && zcompile $f
	done

	for f in "$ZDOTDIR"/zshrc.d/*.zsh; do
		source $f;
	done
}
