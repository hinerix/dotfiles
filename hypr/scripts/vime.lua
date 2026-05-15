local M = {}

M.toggle_vime_window = function ()
  local class_name = "VIME"
  local class_selector = "class:^(" .. class_name .. ")$"
  local vime_client = hl.get_window(class_selector)
  local active_window = hl.get_active_window()

  if vime_client == nil then
    hl.dispatch(hl.dsp.exec_cmd("alacritty --class " .. class_name .. " -o window.opacity=0.85 -e env NVIM_TRANSPARENT=1 nvim -c ':IM' /var/tmp/VIME"))
  elseif active_window and active_window.address == vime_client.address then
    hl.dispatch(hl.dsp.focus({ last = true }))
  else
    hl.dispatch(hl.dsp.focus({ window = class_selector }))
    hl.dispatch(hl.dsp.window.center())
  end
end

return M
