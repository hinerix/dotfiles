if status is-interactive
    set -g theme_display_git_default_branch yes

	#activate mise
	~/.local/bin/mise activate fish | source

	# pnpm
	set -gx PNPM_HOME "/home/hinerix/.local/share/pnpm"
	if not string match -q -- $PNPM_HOME $PATH
	  set -gx PATH "$PNPM_HOME" $PATH
	end
	# pnpm end

end
