if status is-interactive
    set -g theme_display_git_default_branch yes

	# activate mise
	/usr/bin/mise activate fish | source

  # theme
  if test "$TERM" != "linux"
    fish_config theme choose catppuccin-mocha --color-theme=dark
  end

end
