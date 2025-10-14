#!/usr/bin/fish

# 保存先ディレクトリを決定する
if set -q XDG_PICTURES_DIR
    set OUTPUT_DIR $XDG_PICTURES_DIR
else
    set OUTPUT_DIR "$HOME/Pictures"
end

# ディレクトリが存在しない場合は通知して終了する
if not test -d "$OUTPUT_DIR"
    notify-send "Screenshot directory does not exist: $OUTPUT_DIR" -u critical -t 3000
    exit 1
end

set mode $argv[1]
set should_save true

if test "$argv[2]" = "copy-only"
    set should_save false
end

# sattyに渡す共通のオプションをリストとして定義
set satty_options --filename - \
    --early-exit \
    --actions-on-enter save-to-clipboard \
    --copy-command 'wl-copy'

if $should_save
    set -a satty_options --output-filename "$OUTPUT_DIR/screenshot-(date +'%Y-%m-%d_%H-%M-%S').png"
    set -a satty_options --save-after-copy
end

pkill slurp
or hyprshot -m $mode --raw |
    satty $satty_options
