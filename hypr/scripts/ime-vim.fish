#!/usr/bin/fish
set FloatingVim (hyprctl clients -j | jq -c '.[] | select(.class == "FloatingVim" and .floating == true)')
if test -z "$FloatingVim"
	alacritty \
		--class FloatingVim \
		--dimensions 55 18 \
		-o window.opacity=0.5
		-e vim -c ":IM" /var/tmp/ime-vim
else
	if test (echo $FloatingVim | jq .focused) = true
		wtype -k escape 0y$
		hyprctl dispatch movetoworkspace special
	else
		hyprctl dispatch focuswindow "class:^(FloatingVim)$"
	end
end
