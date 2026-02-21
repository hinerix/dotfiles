#!/usr/bin/fish
set -l class_name "VIME"
set vime_client (hyprctl clients -j | jq --arg cn "$class_name" -c '.[] | select(.class == $cn)')

# ウィンドウが存在しない場合
if test -z $vime_client
    # 新しくウィンドウを作成
    alacritty \
        --class $class_name \
        -o 'window.opacity=0.8' \
        -e nvim -c ":IM" /var/tmp/VIME
# ウィンドウが既に存在する場合
else
    # 現在アクティブなウィンドウが"VIME"かチェック
    if string match -q -- $class_name (hyprctl activewindow -j | jq -r .class)
        # そうであれば、直前にフォーカスしていたウインドウにフォーカスを移す
				hyprctl dispatch focuscurrentorlast
    else
        # 違っていれば、"VIME"ウィンドウにフォーカスを移して中央に表示
        hyprctl dispatch focuswindow "class:^($class_name)\$"
        hyprctl dispatch centerwindow
    end
end
