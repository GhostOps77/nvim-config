return {
  "folke/lazydev.nvim",
  ft = "lua", -- only load on lua files
  -- enabled = false,
  condn = function()
    local file_path = vim.fn.expand("%:p")
    local config_path = vim.fn.expand("~/.config/nvim/")
    return file_path:find(vim.pesc(config_path), 1, true)
  end,
  opts = {
    library = {
      -- See the configuration section for more details
      -- Load luvit types when the `vim.uv` word is found
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
  -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
}
