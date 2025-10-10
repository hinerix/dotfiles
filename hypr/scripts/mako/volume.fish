#!/usr/bin/fish

set iDIR "$HOME/.config/mako/icons"

# アイコンのパスを取得する。音量を引数として受け取る
function get_volume_icon --argument current_volume
    if test "$current_volume" -eq 0
        echo "$iDIR/volume-mute.png"
    else if test "$current_volume" -le 30
        echo "$iDIR/volume-low.png"
    else if test "$current_volume" -le 60
        echo "$iDIR/volume-mid.png"
    else
        echo "$iDIR/volume-high.png"
    end
end

# 通知を送信する。アイコンパスと音量を引数として受け取る
function notify_volume --argument icon_path --argument current_volume
    notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon_path" "Volume: $current_volume %"
end

# 音量を上げる（メインロジック）
function inc_volume
    pamixer -i 5
    # pamixerの呼び出しを1回にまとめる
    set vol (pamixer --get-volume)
    set icon (get_volume_icon $vol)
    notify_volume "$icon" $vol
end

# 音量を下げる（メインロジック）
function dec_volume
    pamixer -d 5
    set vol (pamixer --get-volume)
    set icon (get_volume_icon $vol)
    notify_volume "$icon" $vol
end

# ミュートを切り替える
function toggle_mute
    pamixer -t
    # 状態に応じて変数を用意し、重複コードを削除
    if test (pamixer --get-mute) = "true"
        set icon "$iDIR/volume-mute.png"
        set message "Volume Switched OFF"
    else
        set vol (pamixer --get-volume)
        set icon (get_volume_icon $vol)
        set message "Volume: $vol %"
    end
    notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "$message"
end

# --- Microphone Functions ---

# マイクのミュートを切り替える
function toggle_mic
    pamixer --default-source -t
    if test (pamixer --default-source --get-mute) = "true"
        set icon "$iDIR/microphone-mute.png"
        set message "Microphone Switched OFF"
    else
        set icon "$iDIR/microphone.png"
        set message "Microphone Switched ON"
    end
    notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "$message"
end

# マイク音量を上げる
function inc_mic_volume
    pamixer --default-source -i 5
    set vol (pamixer --default-source --get-volume)
    notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/microphone.png" "Mic-Level: $vol %"
end

# マイク音量を下げる
function dec_mic_volume
    pamixer --default-source -d 5
    set vol (pamixer --default-source --get-volume)
    notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/microphone.png" "Mic-Level: $vol %"
end

# 引数に応じて関数を実行
switch $argv[1]
    case --get
        pamixer --get-volume
    case --inc
        inc_volume
    case --dec
        dec_volume
    case --toggle
        toggle_mute
    case --toggle-mic
        toggle_mic
    case --mic-inc
        inc_mic_volume
    case --mic-dec
        dec_mic_volume
    case '*' # デフォルトの動作
        pamixer --get-volume
end
