-- See https://wiki.hypr.land/Configuring/Keywords/

require("bindings.media")
require("bindings.tiling")
require("bindings.utils")

local toggle_vime_window = require("scripts.vime").toggle_vime_window
local slack_shortcut_key = require("scripts.slack").slack_shortcut_key
local spotify_shortcut_key = require("scripts.spotify").spotify_shortcut_key

local terminal = "alacritty"
local menu = "walker"
local browser = "firefox"

hl.bind("SUPER + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(menu))
hl.bind("SUPER + B", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd(browser .. " --private-window"))
hl.bind("SUPER + T", hl.dsp.exec_cmd("alacritty -e btop"))
hl.bind("CTRL + SPACE", function () toggle_vime_window() end)
hl.bind("SUPER + V", hl.dsp.exec_cmd("alacritty --class clipse -e clipse"))
hl.bind("SUPER + M", function () spotify_shortcut_key() end)
hl.bind("SUPER + C", function () slack_shortcut_key() end)
hl.bind("SUPER + CTRL + escape", hl.dsp.exit())
