return {
  {
    'Bekaboo/dropbar.nvim',
    event = { 'BufRead', 'InsertEnter' },
    keys = {
      {
        '<leader>;',
        function()
          require('dropbar.api').pick()
        end,
        desc = 'Pick symbols in winbar',
        mode = { 'n' },
      },
      {
        '[;',
        function()
          require('dropbar.api').goto_context_start()
        end,
        desc = 'Go to start of current context',
        mode = { 'n' },
      },
      {
        '];',
        function()
          require('dropbar.api').select_next_context()
        end,
        desc = 'Select next context',
        mode = { 'n' },
      },
    },
    opts = {
      icons = {
        kinds = {
          file_icon = function(_)
            return "", ""
          end,
          folder_icon = function(_)
            return "", ""
          end,
        }
      }
    },
    config = function()
      local dropbar_api = require('dropbar.api')
      vim.keymap.set('n', '<leader>ll', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
      vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
      vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })

      vim.ui.select = require('dropbar.utils.menu').select
    end
  }
}
