local tmux_target

local function choose_target_if_necessary()
  if (tmux_target == nil) then
    tmux_target = vim.fn.input("Tmux target pane please: ")
  end
end

local function format_for_send_keys(selected_string)
  local modified_string = vim.fn.substitute(selected_string, [["]], [[\\"]], "g")
  modified_string = vim.fn.substitute(modified_string, [[#]], [[\\#]], "g")
  return modified_string
end

local function get_visual()
  local _, ls, cs = unpack(vim.fn.getpos('v'))
  local _, le, ce = unpack(vim.fn.getpos('.'))
  return vim.api.nvim_buf_get_text(0, ls-1, cs-1, le-1, ce, {})
end


local function get_visual_mark()
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  return vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
end




local function send_visual_selection_to_tmux()
  choose_target_if_necessary()
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
  -- vim.cmd([[silent !tmux send-keys -t ]]..tmux_target..[[ Enter]])
  return start_line, end_line
end



local function send_current_line_to_tmux()
  choose_target_if_necessary()
  local line = vim.api.nvim_get_current_line()
  vim.cmd([[silent !tmux send-keys -t ]]..tmux_target..[[ "]]..format_for_send_keys(line)..[[" Enter]])
end


return {
  send_visual_selection_to_tmux=  send_visual_selection_to_tmux,
  send_current_line_to_tmux=  send_current_line_to_tmux,
  get_visual = get_visual,
  get_visual_mark = get_visual_mark
}
