-- Inline Debug Text
return {
  -- https://github.com/theHamsta/nvim-dap-virtual-text
  'theHamsta/nvim-dap-virtual-text',
  event = { "InsertEnter", 'BufReadPre', 'BufNewFile' },
  dependencies  = {
    'mfussenegger/nvim-dap',
  },
  opts = {
    -- Display debug text as a comment
    commented = true,
    -- Customize virtual text
    display_callback = function(variable, buf, stackframe, node, options)
      if options.virt_text_pos == 'inline' then
        return ' = ' .. variable.value
      else
        return variable.name .. ' = ' .. variable.value
      end
    end,
  },
  config = function(_, opts)
    -- Customize breakpoint signs
    vim.api.nvim_set_hl(0, "DapStoppedHl", { fg = "#98BB6C", bg = "#2A2A2A", bold = true })
    vim.api.nvim_set_hl(0, "DapStoppedLineHl", { bg = "#204028", bold = true })

    vim.fn.sign_define('DapStopped', { text='', texthl='DapStoppedHl', linehl='DapStoppedLineHl', numhl= '' })
    vim.fn.sign_define('DapBreakpoint', { text='', texthl='DiagnosticSignError', linehl='', numhl='' })
    vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='DiagnosticSignWarn', linehl='', numhl='' })
    vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DiagnosticSignError', linehl='', numhl= '' })
    vim.fn.sign_define('DapLogPoint', { text='', texthl='DiagnosticSignInfo', linehl='', numhl= '' })
  end
}
