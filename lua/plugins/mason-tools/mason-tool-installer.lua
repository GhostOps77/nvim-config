return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  enabled = false,
  -- cmd = { 'Mason' },
  opts = {
    -- Install these linters, formatters, debuggers automatically
    ensure_installed = {
      'black',
      'debugpy',
      'flake8',
      'isort',
      'mypy',
      -- 'pylint',
      'ruff'
    },
    -- if set to true this will check each tool for updates. If updates
    -- are available the tool will be updated. This setting does not
    -- affect :MasonToolsUpdate or :MasonToolsInstall.
    -- Default: false
    auto_update = true,

    -- automatically install / update on startup. If set to false nothing
    -- will happen on startup. You can use :MasonToolsInstall or
    -- :MasonToolsUpdate to install tools and check for updates.
    -- Default: true
    run_on_start = false,

    -- set a delay (in ms) before the installation starts. This is only
    -- effective if run_on_start is set to true.
    -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
    -- Default: 0
    start_delay = 3000, -- 3 second delay

    -- By default all integrations are enabled. If you turn on an integration
    -- and you have the required module(s) installed this means you can use
    -- alternative names, supplied by the modules, for the thing that you want
    -- to install. If you turn off the integration (by setting it to false) you
    -- cannot use these alternative names. It also suppresses loading of those
    -- module(s) (assuming any are installed) which is sometimes wanted when
    -- doing lazy loading.
    -- integrations = {
    --   ['mason-lspconfig'] = true,
    --   ['mason-null-ls'] = true,
    --   ['mason-nvim-dap'] = true,
    -- },
  },
  -- init = function()
  --   -- There is an issue with mason-tools-installer running with VeryLazy,
  --   -- since it triggers on VimEnter which has already occurred prior to this plugin
  --   -- loading so we need to call install explicitly
  --   -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim/issues/39
  --   vim.api.nvim_command('MasonToolsInstall')
  -- end
}
