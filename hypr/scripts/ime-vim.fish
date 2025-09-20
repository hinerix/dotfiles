#!/usr/bin/fish
set VIME (hyprctl clients -j | jq -c '.[] | select(.class == "VIME")')
if test -z "$VIME"
    alacritty \
        --class VIME \
        -o 'window.dimensions.columns=55' \
        -o 'window.dimensions.lines=18' \
        -o 'window.opacity=0.5' \
        -e nvim -c ":IM" /var/tmp/ime-vim
else
    if test (hyprctl activewindow -j | jq -r .class) = "VIME"
        # もしウィンドウがフォーカスされている場合
				hyprctl dispatch movetoworkspace special
				hyprctl dispatch togglespecialworkspace
    else
        # もしウィンドウがフォーカスされていない場合
        hyprctl dispatch focuswindow 'class:^(VIME)$'
    end
end
