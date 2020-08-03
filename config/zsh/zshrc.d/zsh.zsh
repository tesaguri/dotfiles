HISTFILE="${XDG_DATA_HOME:-${HOME}/.local/share/zsh}/history"
mkdir -p $(dirname $HISTFILE)
HISTSIZE=100000
SAVEHIST=10000000
setopt extended_history

bindkey -e

fpath=("$ZDOTDIR/functions" $fpath)
fpath+=~/.zfunc

autoload -Uz compinit
local zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
mkdir -p $(dirname $zcompdump)
compinit -d $zcompdump

PROMPT='%0(?.%F{green}✔.%F{red}✘[%?])%f%n@%m%# '
RPROMPT=%~
