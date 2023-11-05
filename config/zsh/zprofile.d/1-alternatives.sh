if command -v nvim > /dev/null; then
	export EDITOR=nvim
elif command -v vim > /dev/null; then
	export EDITOR=vim
fi

if command -v delta > /dev/null; then
	export GIT_PAGER='delta --color-only'
fi
