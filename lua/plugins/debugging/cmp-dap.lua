return {
  'rcarriga/cmp-dap',
  -- event = { 'InsertEnter' },
  dependencies = {
    -- 'hrsh7th/nvim-cmp',
    'rcarriga/nvim-dap-ui'
  },
  enabled = function()
    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
      or require("cmp_dap").is_dap_buffer()
  end,
  config = function()
    require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
      sources = {
        { name = "dap" },
      },
    })
  end
}
