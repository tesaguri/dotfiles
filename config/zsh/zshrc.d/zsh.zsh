HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=100000
SAVEHIST=10000000
setopt extended_history

bindkey -e

fpath=("$ZDOTDIR/functions" $fpath)
fpath+=~/.zfunc

autoload -Uz compinit
mkdir -p "$HOME/.cache/zsh"
compinit -d "$HOME/.cache/zsh/zcompdump"

PROMPT='%0(?.%F{green}✔.%F{red}✘[%?])%f%n@%m%# '
RPROMPT=%~
