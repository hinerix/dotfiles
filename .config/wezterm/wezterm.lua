local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- テーマの設定
config.color_scheme = 'Catppuccin Mocha'

-- ウィンドウの設定
config.window_background_opacity = 0.85
config.adjust_window_size_when_changing_font_size = false
config.tab_bar_at_bottom = true

-- フォントの設定
config.font = wezterm.font("HackGen Console NF", { weight = "Regular", stretch = "Normal", style = "Normal" })

-- タブの設定
config.hide_tab_bar_if_only_one_tab = true

-- WSL2をデフォルトで起動する
config.default_domain = "WSL:Ubuntu-24.04"

-- キーボードの設定
config.use_ime = true
config.disable_default_key_bindings = true
config.keys = {
	{ key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "n", mods = "SHIFT|CTRL", action = act.SpawnWindow },
	{ key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
	{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
	{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
	{ key = "0", mods = "CTRL", action = act.ResetFontSize },
	{ key = "t", mods = "SHIFT|CTRL", action = act.SpawnTab("DefaultDomain") },
	{ key = "w", mods = "SHIFT|CTRL", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "1", mods = "CTRL", action = act.ActivatePaneByIndex(0) },
	{ key = "2", mods = "CTRL", action = act.ActivatePaneByIndex(1) },
	{ key = "3", mods = "CTRL", action = act.ActivatePaneByIndex(2) },
	{ key = "4", mods = "CTRL", action = act.ActivatePaneByIndex(3) },
	{ key = "5", mods = "CTRL", action = act.ActivatePaneByIndex(4) },
	{ key = "6", mods = "CTRL", action = act.ActivatePaneByIndex(5) },
	{ key = "7", mods = "CTRL", action = act.ActivatePaneByIndex(6) },
	{ key = "8", mods = "CTRL", action = act.ActivatePaneByIndex(7) },
	{ key = "9", mods = "CTRL", action = act.ActivatePaneByIndex(8) },
	{ key = "{", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(-1) },
	{ key = "}", mods = "SHIFT|CTRL", action = act.ActivateTabRelative(1) },
	{ key = "r", mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
	{ key = "k", mods = "SHIFT|CTRL", action = act.ClearScrollback("ScrollbackOnly") },
	{ key = "l", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
	{ key = "p", mods = "SHIFT|CTRL", action = act.ActivateCommandPalette },
	{ key = "u", mods = "SHIFT|CTRL", action = act.CharSelect({ copy_on_select = false }) },
	{ key = "f", mods = "SHIFT|CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
	{ key = "x", mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
	{ key = "/", mods = "ALT", action = act.QuickSelect },
	{ key = "z", mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
	{ key = "-", mods = "ALT", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "p", mods = "ALT", action = act.PaneSelect },
	{ key = "n", mods = "ALT", action = act.RotatePanes("Clockwise") },
	{ key = "n", mods = "SHIFT|ALT", action = act.RotatePanes("CounterClockwise") },
	{ key = "\\", mods = "ALT", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "h", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Left" }) },
	{ key = "l", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Right" }) },
	{ key = "k", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Up" }) },
	{ key = "j", mods = "ALT|SHIFT", action = act({ ActivatePaneDirection = "Down" }) },
	{ key = "h", mods = "ALT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Left", 1 } }) },
	{ key = "l", mods = "ALT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Right", 1 } }) },
	{ key = "k", mods = "ALT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Up", 1 } }) },
	{ key = "j", mods = "ALT|SHIFT|CTRL", action = act({ AdjustPaneSize = { "Down", 1 } }) },
}

-- コマンドパレットの設定
config.ui_key_cap_rendering = "WindowsSymbols"
config.command_palette_font_size = 12.0

return config
