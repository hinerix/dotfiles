#!/usr/bin/fish

set iDIR "~/.config/mako/icons"

# 現在のキーボードバックライトの輝度を取得する関数
function get_backlight
    cat /sys/class/leds/*::kbd_backlight/brightness
brightnessctl -d '*::kbd_backlight' g
end

# 輝度レベルに応じてアイコンを取得する関数
function get_icon
    set current (cat /sys/class/leds/*::kbd_backlight/brightness)

    if test "$current" -ge 0 -a "$current" -le 1
        set icon "$iDIR/brightness-20.png"
    else if test "$current" -ge 1 -a "$current" -le 2
        set icon "$iDIR/brightness-60.png"
    else if test "$current" -ge 2 -a "$current" -le 3
        set icon "$iDIR/brightness-100.png"
    end
end

# 通知を送信する関数
function notify_user
    notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "Keyboard Brightness : "(brightnessctl -d '*::kbd_backlight' g)
end

# 輝度を上げる関数
function inc_backlight
    brightnessctl -d "*::kbd_backlight" set 33%+; and get_icon; and notify_user
end

# 輝度を下げる関数
function dec_backlight
    brightnessctl -d "*::kbd_backlight" set 33%-; and get_icon; and notify_user
end

# 輝度をゼロにする関数
function zero_backlight
    brightnessctl -d "*::kbd_backlight" s 0%
end

# 輝度を最大にする関数
function full_backlight
    brightnessctl -d "*::kbd_backlight" s 100%
end

# スクリプトの引数に応じて処理を実行
switch $argv[1]
    case --get
        brightnessctl -d '*::kbd_backlight' g
    case --inc
        inc_backlight
    case --dec
        dec_backlight
    case --zero
        zero_backlight
    case --full
        full_backlight
    case '*' # デフォルトのケース（引数がない、または一致しない場合）
        get_backlight
end
