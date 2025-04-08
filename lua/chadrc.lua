-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options

-- local separators = { left = "", right = "" },
-- local sep_l = separators["left"]
-- local sep_r = separators["right"]


---@type ChadrcConfig
return {
  base46 = {
    theme = "ayu_dark",

    -- hl_override = {
    -- 	Comment = { italic = true },
    -- 	["@comment"] = { italic = true },
    -- },
  },

  -- nvdash = { load_on_startup = true }
  ui = {
  --   tabufline = {
  --       lazyload = false
  --   },
  --   cmp = {
  --     icons = true,
  --     lspkind_text = false,
  --     style = "default", -- default/flat_light/flat_dark/atom/atom_colored
  --     border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
  --     selected_item_bg = "colored", -- colored / simple
  --   },
    statusline = {
      -- order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
      modules = {
        lsp = function()
          if rawget(vim, "lsp") then
            local stbufnr_val = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)

            for _, client in ipairs(vim.lsp.get_clients()) do
              if client.attached_buffers[stbufnr_val] then
                return " " .. (vim.o.columns > 100 and " " .. client.name or "")
              end
            end
          end
          return ""
        end,
        file = function()
          local icon = vim.bo.modified and "󰧭" or "󰈚"
          local stbufnr_val = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)

          local path = vim.api.nvim_buf_get_name(stbufnr_val)
          local name = (path == "" and "Empty") or path:match "([^/\\]+)[/\\]*$"

          if name ~= "Empty" then
            local devicons_present, devicons = pcall(require, "nvim-web-devicons")

            if devicons_present then
              local ft_icon = devicons.get_icon(name)
              icon = (ft_icon ~= nil and ft_icon) or icon
              name = ""
            end
          end

          return { icon, name }
        end
      }
    }
  },

  term = {
    sizes = { vsp = 0.4 }
  },

  themes = {
    border = true
  }
}
