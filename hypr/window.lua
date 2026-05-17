-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- VIME
hl.window_rule({
	name = "VIME",
	match = {
    class = "^(VIME)$",
  },
	size = {"(monitor_h*0.6)", "(monitor_h*0.5)"},
	float = true,
	workspace = "special:VIME",
  no_blur = true
})

-- clipse
hl.window_rule({
  name = "clipse",
  match = {
    class = "^(clipse)$",
  },
  float = true,
})

-- spotify
hl.window_rule({
  name = "spotify",
  match = {
    class = "^(spotify)$",
  },
})

-- slack
hl.window_rule({
  name = "slack",
  match = {
    class = "^(slack)$",
  },
})
