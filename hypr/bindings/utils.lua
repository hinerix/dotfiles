-- ScreenShot
-- 単押しでウインドウ、SHIFTで画面全体
hl.bind("Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.fish window copy-only"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.fish output copy-only"))
hl.bind("XF86SelectiveScreenshot", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.fish region copy-only"))

-- CTRLでファイル保存
hl.bind("CTRL + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.fish window"))
hl.bind("CTRL + SHIFT + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.fish output"))
hl.bind("CTRL + XF86SelectiveScreenshot", hl.dsp.exec_cmd("~/.config/hypr/scripts/screenshot.fish region"))
