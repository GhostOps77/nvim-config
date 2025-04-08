return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
  },
  opts = {
    -- Install these LSPs automatically
    ensure_installed = {
      -- 'bashls',
      -- 'cssls',
      -- 'html',
      'lua_ls',
      -- 'jsonls',
      -- 'lemminx',
      -- 'marksman',
      -- 'quick_lint_js',
      -- 'yamlls',
      -- "pyright",
      -- 'ruff',
      -- 'ruff_lsp',
    },
    automatic_installation = true
  },
  config = function()
    require("mason").setup()
  end
}
