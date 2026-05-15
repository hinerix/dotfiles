local M = {}

M.slack_shortcut_key = function ()
  local class_name = "slack"
  local class_selector = "class:^(" .. class_name .. ")$"
  local slack_client = hl.get_window(class_selector)
  local active_window = hl.get_active_window()

  if slack_client == nil then
    hl.dispatch(hl.dsp.exec_cmd("slack"))
  elseif active_window and active_window.address == slack_client.address then
    hl.dispatch(hl.dsp.focus({ last = true }))
  else
    hl.dispatch(hl.dsp.focus({ window = class_selector }))
  end
end

return M
