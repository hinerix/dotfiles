#!/usr/bin/fish
set -l class_name "spotify"
set spotify_client (hyprctl clients -j | jq --arg cn "$class_name" -c '.[] | select(.class == $cn)')

if test -z $spotify_client
    spotify
else
    if test "$class_name" != (hyprctl activewindow -j | jq -r .class)
        hyprctl dispatch focuswindow "class:^($class_name)\$"
    end
end
