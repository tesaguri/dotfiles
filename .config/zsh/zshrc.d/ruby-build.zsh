# <https://github.com/Homebrew/homebrew-core/blob/7d55e99/Formula/ruby-build.rb#L22>
[ -e /usr/local/opt/openssl@1.1 ] &&
	export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1"
