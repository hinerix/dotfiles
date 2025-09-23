#!/usr/bin/fish
set -l class_name "Spotify"
set spotify_client (hyprctl clients -j | jq --arg cn "$class_name" -c '.[] | select(.class == $cn)')

if test -z $spotify_client
		spotify
else
    if string match -q -- $class_name (hyprctl activewindow -j | jq -r .class)
        hyprctl dispatch togglespecialworkspace $class_name
    else
        hyprctl dispatch focuswindow "class:^($class_name)\$"
    end
end
