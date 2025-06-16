if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U FZF_LEGACY_KEYBINDINGS 0
    set -g theme_display_git_default_branch yes

	#abbr
	abbr ls ls -alSh
	abbr vi nvim
	abbr vim nvim
	abbr pn pnpm

	#activate mise
	~/.local/bin/mise activate fish | source

	# pnpm
	set -gx PNPM_HOME "/home/masakia/.local/share/pnpm"
	if not string match -q -- $PNPM_HOME $PATH
	  set -gx PATH "$PNPM_HOME" $PATH
	end
	# pnpm end

end
