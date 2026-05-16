-- https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
  output = "eDP-1",
  mode = "preferred",
  position = "auto",
  scale = 1.25,
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "preferred",
  position = "auto-up",
  scale = 1,
})

-- Lid Switchは on = 閉じてる状態
hl.bind("switch:off:Lid Switch", hl.dsp.dpms({action = "on"}), { locked = true })
hl.bind("switch:on:Lid Switch", hl.dsp.dpms({action = "off"}), { locked = true })
