return {
  -- snippet plugin
  "L3MON4D3/LuaSnip",
  event = { "InsertEnter" },
  dependencies = {
    "rafamadriz/friendly-snippets"
  },
  build = "make install_jsregexp",
  opts = {
    history = true,
    updateevents = "TextChanged,TextChangedI"
  },
  config = function(_, opts)
    local luasnip = require("luasnip")
    luasnip.config.set_config(opts)

    -- for jsx, tsx code environment.
    luasnip.filetype_extend("javascriptreact", { "html" })
    luasnip.filetype_extend("typescriptreact", { "html" })
    luasnip.filetype_extend("svelte", { "html" })

    -- vscode format
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load { paths = "./lua/snippets" }

    -- disable luasnip after leaving insert mode.
    vim.api.nvim_create_autocmd("InsertLeave", {
      callback = function()
        local luasnip = require("luasnip")
        if
          luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
          and not luasnip.session.jump_active
        then
          luasnip.unlink_current()
        end
      end,
    })
  end,
}