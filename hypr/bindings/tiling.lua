-- Kill window
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close("activewindow"))
hl.bind("SUPER + CTRL + Q", hl.dsp.window.kill("activewindow"))

-- Move current workspace to other monitor
hl.bind("SUPER + CTRL + M", hl.dsp.workspace.move({ monitor = "+1" }))

-- Toggle float
hl.bind("SUPER + CTRL + F", hl.dsp.window.float({ "toggle", "activewindow" }))

-- Move focus
hl.bind("SUPER + H", hl.dsp.layout("focus l"))
hl.bind("SUPER + L", hl.dsp.layout("focus r"))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))

-- Moves a window to its own new column
hl.bind("SUPER + P", hl.dsp.layout("promote"))

-- Resize the current column
hl.bind("SUPER + equal", hl.dsp.layout("colresize +conf"))
hl.bind("SUPER + minus", hl.dsp.layout("colresize -conf"))
hl.bind("SUPER + SHIFT + equal", hl.dsp.layout("colresize +0.1"))
hl.bind("SUPER + SHIFT + minus", hl.dsp.layout("colresize -0.1"))

-- Switch workspaces with mainMod + [1-9]
-- Move active window to a workspace with mainMod + SHIFT + [1-9]
for i = 1, 9 do
    hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i}))
    hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Move window
hl.bind("SUPER + CTRL + H", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + CTRL + L", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + CTRL + K", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + CTRL + J", hl.dsp.window.move({ direction = "d" }))


-- Swap window
hl.bind("SUPER + SHIFT + H", hl.dsp.layout("swapcol l"))
hl.bind("SUPER + SHIFT + L", hl.dsp.layout("swapcol r"))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.swap({ direction = "u" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.swap({ direction = "d" }))

-- Example special workspace (scratchpad)
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
