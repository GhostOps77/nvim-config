-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options

local separators = { left = "", right = "" }
local sep_l = separators["left"]
local sep_r = separators["right"]


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
      theme = 'default',
      order = {
        "mode",
        "file",
        "git",
        "%=",
        "lsp_msg",
        "%=",
        -- "macro",
        "python_venv",
        "diagnostics",
        "lsp",
        "cwd",
        "cursor"
      },
      modules = {
        python_venv = function()
          -- only show virtual env for Python
          if vim.bo.filetype ~= 'python' then
            return ""
          end

          local conda_env = os.getenv('CONDA_DEFAULT_ENV')
          local venv_path = os.getenv('VIRTUAL_ENV')

          if venv_path == nil then
            if conda_env == nil then
              return ""
            else
              return string.format("  %s (conda)", conda_env)
            end
          else
            local venv_name = vim.fn.fnamemodify(venv_path, ':t')
            return string.format("  %s (venv)", venv_name)
          end
        end,

        lsp = function()
          if rawget(vim, "lsp") then
            local stbufnr_val = vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)

            for _, client in ipairs(vim.lsp.get_clients()) do
              if client.attached_buffers[stbufnr_val] then
                local text = (vim.o.columns > 100 and " %#St_Lsp_text#" .. client.name or "")
                return "%#St_Lsp_sep#%#St_Lsp_icon# " .. text
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
            end
            local name = " " .. name .. (sep_style == "default" and " " or "")
  
          else
            name = ""
          end

          return "%#St_file# " .. icon .. name .. "%#St_file_sep#" .. sep_r
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
