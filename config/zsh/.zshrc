for f in "$ZDOTDIR"/{functions/*[^.zwc],.zshrc,zshrc.d/*[^.zwc]}; do
	([ ! -e $f.zwc ] || [[ $f -nt $f.zwc ]]) && zcompile $f
done

for f in "$ZDOTDIR"/zshrc.d/*[^.zwc]; do
	source $f;
done
