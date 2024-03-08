-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, 's', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- navigation
vim.keymap.set({'n', 'i','v'}, '<c-j>', '<c-w>j')
vim.keymap.set({'n', 'i','v'}, '<c-k>', '<c-w>k')
vim.keymap.set({'n', 'i','v'}, '<c-l>', '<c-w>l')
vim.keymap.set({'n', 'i','v'}, '<c-h>', '<c-w>h')

-- Sortir du mode insertion
vim.keymap.set({'i'}, '<c-c>', '<nop>')
vim.keymap.set({'i', 'v'}, 'jk', '<esc>')
vim.keymap.set('t', '<ESC>'  ,  '<C-\\><C-n>'  ,  {noremap = true}  )

vim.keymap.set({'n'}, '<leader>ev', '<Cmd>split $MYVIMRC<CR>')

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


vim.keymap.set({'n'}, '<leader>f', ":NvimTreeToggle<CR>", { desc = 'Open NvimTree file explorer' })

-- vim: ts=2 sts=2 sw=2 et

local tmux_sender = require('tmux-sender')
vim.api.nvim_create_user_command('TmuxSendLine', tmux_sender.send_current_line_to_tmux,{} )
vim.api.nvim_create_user_command('TmuxSendSelection', tmux_sender.send_visual_selection_to_tmux, {range=true})

vim.keymap.set({'n'}, '<C-x><C-x>', ":TmuxSendLine<CR>j", { desc = 'Execute current line in tmux pane' })
vim.keymap.set({'v'}, '<C-x>', ":TmuxSendSelection<CR>`>", { desc = 'Execute current visual selection in tmux pane' })
vim.keymap.set({'i'}, '<C-x>', "<esc>:TmuxSendLine<CR>o", { desc = 'Execute current visual selection in tmux pane' })

-- vim.keymap.set({'n'}, '<C-x><C-b>', '<Cmd>SlimuxREPLSendBuffer<cr>')


-- ################    OBSIDIAN        ##########################
--
--
--
--


vim.keymap.set('n', '<leader>ol', ":ObsidianQuickSwitch<CR>", { desc = '[O]bsidian [L]ist files in vault' })
vim.keymap.set('n', '<leader>ot', ":ObsidianToday<CR>", { desc = '[O]bsidian [T]oday' })
vim.keymap.set('n', '<leader>oy', ":ObsidianYesterday<CR>", { desc = '[O]bsidian [Y]esterday' })
vim.keymap.set('n', '<leader>oT', ":ObsidianTomorrow<CR>", { desc = '[O]bsidian [T]omorrow' })
