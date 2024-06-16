# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html

export XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

XDG_CONFIG_DIRS="${XDG_CONFIG_DIRS:-/etc/xdg}"
XDG_DATA_DIRS="${XDG_DATA_DIRS:-/usr/local/share/:/usr/share/}"

if [ "$(uname -s)" = 'Darwin' ]; then
	# Prefer macOS-specific cache directory for better handling by Time Machine.
	export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/Library/Caches}"
	export XDG_RUNTIME_DIR="$HOME/Library/Caches/TemporaryItems"
	# Add macOS-specific config/data directories as fallbacks to the XDG's default ones.
	XDG_CONFIG_DIRS="$HOME/Library/Preferences/:$XDG_CONFIG_DIRS"
	XDG_DATA_DIRS="$HOME/Library/:$XDG_DATA_DIRS"
else
	export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
fi

export XDG_CONFIG_DIRS
export XDG_DATA_DIRS
