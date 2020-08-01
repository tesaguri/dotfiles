for f in "$ZDOTDIR"/{.zprofile,zprofile.d/*[^.zwc]}; do
	([ ! -e $f.zwc ] || [[ $f -nt $f.zwc ]]) && zcompile $f
done

for f in "$ZDOTDIR"/zprofile.d/*[^.zwc]; do
	source $f;
done
