return {
  {
    'Vigemus/iron.nvim',
    lazy = false,
    config = function()
      require("iron.core").setup({
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "zsh" }
            },
            python = {
              command = { "python" }, -- or { "ipython", "--no-autoindent" }
              format = require("iron.fts.common").bracketed_paste_python
            }
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = require('iron.view').bottom(40),
        },
      })
    end
  }
}
