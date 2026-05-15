-- https://wiki.hypr.land/Configuring/Basics/Variables/#input

hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "ctrl:nocaps",
    kb_rules = "",
		repeat_rate = 40,
		repeat_delay = 300,
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = {
				scroll_factor = 0.4,
        natural_scroll = true,
				tap_and_drag = false,
    },
  },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/

hl.gesture({
  fingers = 4,
  direction = "horizontal",
  action = "workspace",
})
hl.gesture({
  fingers = 3,
  direction = "left",
  action = "scroll_move",
})
hl.gesture({
  fingers = 3,
  direction = "right",
  action = "scroll_move",
})
