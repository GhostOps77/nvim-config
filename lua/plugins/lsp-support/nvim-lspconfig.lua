local merge = vim.tbl_deep_extend

local x = vim.diagnostic.severity


return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "LspInfo", "LspInstall", "LspUninstall" },
  opts = {
    -- options for vim.diagnostic.config()
    diagnostics = {
      signs = {
        text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" }
      },
      float = { border = "single" },
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
      },
      severity_sort = true,
    }
  },
  dependencies = {
    -- LSP Management
    -- https://github.com/williamboman/mason.nvim
    { 'williamboman/mason.nvim' },
    -- https://github.com/williamboman/mason-lspconfig.nvim
    { 'williamboman/mason-lspconfig.nvim' },

    -- Auto-Install LSPs, linters, formatters, debuggers
    -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
    -- { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

    {
      "hrsh7th/cmp-nvim-lsp",
      dependencies = {
        'hrsh7th/nvim-cmp'
      },
      -- cond = function()
      --   -- No module named 'lazyvim.util' found.
      --   return require("lazyvim.util").has("nvim-cmp")
      -- end,
    }
  },
  config = function(_, opts)
    dofile(vim.g.base46_cache .. 'lsp')
    -- require('mason').setup()

    vim.diagnostic.config(opts.diagnostics)

    -- Call mason lspconfig's default config setup
    local mason_lspconfig = require 'mason-lspconfig'
    -- mason_lspconfig.setup()
    -- require('mason-tool-installer').setup({})

    -- Call nvchad's default setup config on each LSP server
    -- local nvlsp = require "nvchad.configs.lspconfig"
    -- nvlsp.defaults()

    local lspconfig = require 'lspconfig'
    local cmp_lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    mason_lspconfig.setup_handlers {
      function(server_name)
        success, result = pcall(require, 'config.lsp.' .. server_name)
        default_server_config = success and result or {}

        -- merging lsps config with default and custom configs
        lspconfig[server_name].setup(merge('force', {
          capabilities = cmp_lsp_capabilities
        }, default_server_config))
      end
    }

    -- Globally configure all LSP floating preview popups (like hover, signature help, etc)
    local open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded" -- Set border to rounded
      return open_floating_preview(contents, syntax, opts, ...)
    end
  end
}
