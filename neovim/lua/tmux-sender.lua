local tmux_target

local function choose_target_if_necessary()
  if (tmux_target == nil) then
    tmux_target = vim.fn.input("Tmux target pane please: ")
  end
end

local function format_for_send_keys(selected_string)
  local modified_string = vim.fn.substitute(selected_string, [["]], [[\\"]], "g")
  modified_string = vim.fn.substitute(modified_string, [[#]], [[\\#]], "g")
  modified_string = vim.fn.substitute(modified_string, [[!]], [[\\!]], "g")
  modified_string = vim.fn.substitute(modified_string, [[%]], [[\\%]], "g")
  return modified_string
end

local function exit_copy_mode_if_necessary()
  local cmd = [[tmux display-message -p -F '#{pane_in_mode}' -t ]]..tmux_target
  -- local cmd_output = vim.api.nvim_exec2(cmd,{output=true})
  local cmd_output = vim.fn.system(cmd)
  if string.sub(cmd_output,1,1) == '1' then
    print("desactivating tmux copy mode before sending code")
    vim.fn.system([[tmux send-keys -X -t ]]..tmux_target..[[ cancel]])
  end
end


local function send_visual_selection_to_tmux()
  choose_target_if_necessary()
  exit_copy_mode_if_necessary()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  -- alternative si on ne veut pas de lignes entières mais la selection visuelle:
  -- nvim_buf_get_text
  -- print(vim.inspect(lines))
  for k,v in pairs(lines) do
    -- en envoyant ligne à ligne ça semble bien fonctionner
    vim.cmd([[silent !tmux send-keys -t ]]..tmux_target..[[ "]]..format_for_send_keys(v)..[[" Enter]])
  end
  vim.cmd([[silent !tmux send-keys -t ]]..tmux_target..[[ Enter]])
  return start_line, end_line
end


local function send_current_line_to_tmux()
  choose_target_if_necessary()
  exit_copy_mode_if_necessary()
  local line = vim.api.nvim_get_current_line()
  vim.cmd([[silent !tmux send-keys -t ]]..tmux_target..[[ "]]..format_for_send_keys(line)..[[" Enter]])
end


return {
  send_visual_selection_to_tmux=  send_visual_selection_to_tmux,
  send_current_line_to_tmux=  send_current_line_to_tmux
}
