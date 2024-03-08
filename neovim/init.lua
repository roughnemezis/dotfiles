vim.g.mapleader = ','
vim.g.maplocalleader = '%'

local home = vim.env.HOME

vim.g.python_host_prog = home..'/slash/apps/python_venvs/neovim/bin/python'
vim.g.python3_host_prog = home..'/slash/apps/python_venvs/neovim3/bin/python'

local node_bin =  '/.nvm/versions/node/v21.6.2/bin'
-- vim.g.node_host_prog = home .. node_bin .. "/node"
vim.cmd("let $PATH = '" .. home .. node_bin .. ":' . $PATH")

-- for mason.nvim
-- prereq - install lsp server in that node/bin npm i -g typescript-language-server 
-- (handled by :Mason currently)
-- TODO ideas in lua
-- TODO: changer la couleur du terminal selon qu'on est en mode insertion ou pas
-- TODO: depuis le terminal embeddé dans vim, demander l'ouverture d'un fichier dans l'éditeur

require('lazy-bootstrap')
require('lazy-plugins')
require('options')
require('keymaps')
require('nvim-tmux-navigation-setup')
require('nvim-tree-setup')
require('telescope-setup')
require('treesitter-setup')
require('lsp-setup')
require('cmp-setup')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
--#region

-- historic mappings not ported to lua but still useful!

vim.api.nvim_command('source '..vim.fn.stdpath('config')..'/configs.vim')
