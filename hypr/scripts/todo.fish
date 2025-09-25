#!/usr/bin/fish
set -l class_name "todo"
set todo_client (hyprctl clients -j | jq --arg cn "$class_name" -c '.[] | select(.class == $cn)')

if test -z $todo_client
    alacritty \
        --class $class_name \
        -o 'window.opacity=0.4' \
        -e nvim ~/Dropbox/todo.txt
else
    if string match -q -- $class_name (hyprctl activewindow -j | jq -r .class)
        hyprctl dispatch togglespecialworkspace $class_name
    else
        hyprctl dispatch focuswindow "class:^($class_name)\$"
    end
end
