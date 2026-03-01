#!/usr/bin/fish
set -l class_name "Slack"
set slack_client (hyprctl clients -j | jq --arg cn "$class_name" -c '.[] | select(.class == $cn)')

if test -z $slack_client
    slack
else
    if test "$class_name" != (hyprctl activewindow -j | jq -r .class)
        hyprctl dispatch focuswindow "class:^($class_name)\$"
    end
end
