check: check-shell check-lua

check-shell:
	find . \( -name '*.sh' -o -path './local/bin/*' -o -path ./profile \) -exec shellcheck --shell=sh --severity=warning -- {} +
	find . \( -name '*.zsh' -o -path ./config/zsh/.zprofile -o -path ./config/zsh/.zshrc -o -path ./zshenv \) -exec shellcheck --shell=bash --severity=warning -- {} +

check-lua:
	selene .

format: format-lua

format-lua:
	stylua .
