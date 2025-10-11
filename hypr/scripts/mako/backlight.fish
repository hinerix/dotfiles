#!/usr/bin/fish

set -g ICON_DIR "$HOME/.config/mako/icons"
set -g MAX_BRIGHTNESS (brightnessctl max)
set -g BRIGHTNESS_STEPS 5
set -g STEP_SIZE (math "floor($MAX_BRIGHTNESS / $BRIGHTNESS_STEPS)")

# Get brightness
function get_current_backlight
		math "round($(brightnessctl g))"
end

# Get icons
function get_icon_for_brightness --argument current_brightness
		set step_index (math "floor($current_brightness / $STEP_SIZE)")

		switch $step_index
				case 0
						set icon "$ICON_DIR/brightness-20.png"
				case 1
						set icon "$ICON_DIR/brightness-40.png"
				case 2
						set icon "$ICON_DIR/brightness-60.png"
				case 3
						set icon "$ICON_DIR/brightness-80.png"
				case '*'
						set icon "$ICON_DIR/brightness-100.png"
		end
	echo "$icon"
end

# Notify
function notify_user --argument current_brightness
		set icon (get_icon_for_brightness $current_brightness)
		set percentage_of_current_brightness (math "round($current_brightness / $MAX_BRIGHTNESS * 100)")
		notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$icon" "Brightness: $percentage_of_current_brightness %"
end

# Increase brightness
function inc_backlight
		brightnessctl s +5%
		set new_brightness (get_current_backlight)
		notify_user $new_brightness
end

# Decrease brightness
function dec_backlight
		brightnessctl s 5%-
		set new_brightness (get_current_backlight)
		notify_user $new_brightness
end

switch $argv[1]
		case --get
				get_current_backlight
		case --inc
				inc_backlight
		case --dec
				dec_backlight
		case '*'
				get_current_backlight
end
