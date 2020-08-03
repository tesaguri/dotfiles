for f in "$ZDOTDIR"/{.zprofile,zprofile.d/*.zsh}; do
	([ ! -e $f.zwc ] || [[ $f -nt $f.zwc ]]) && zcompile $f
done

for f in "$ZDOTDIR"/zprofile.d/*.zsh; do
	source $f;
done
