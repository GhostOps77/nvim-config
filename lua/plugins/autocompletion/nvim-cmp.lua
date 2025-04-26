-- local cmp_ui = {
--   icons = true,
--   -- lspkind_text = true,
--   lspkind_text = false,
--   style = "default", -- default/flat_light/flat_dark/atom/atom_colored
--   border_color = "grey_fg", -- only applicable for "default" style, use color names from base30 variables
--   selected_item_bg = "colored", -- colored / simple
-- }

local cmp_ui = require 'chadrc'.ui.cmp

local cmp_lsp_icons = {
  Text = ' ',
  -- Method = ' ',
  -- Function = ' ',
  Method = '󰅲 ',
  Function = '󰅲 ',
  Constructor = ' ',
  Field = ' ',
  Variable = ' ',
  Class = ' ',
  Interface = ' ',
  Module = ' ',
  Property = ' ',
  Unit = ' ',
  Value = ' ',
  Enum = ' ',
  Keyword = ' ',
  Snippet = ' ',
  Color = ' ',
  File = ' ',
  Reference = ' ',
  Folder = ' ',
  EnumMember = ' ',
  Constant = ' ',
  Struct = ' ',
  Event = ' ',
  Operator = ' ',
  TypeParameter = ' ',
}

local cmp_custom_src_icons = {
  async_path = "󰿟 ",
  calc = "󰃬 ",
}

bufIsBig = function(bufnr)
	local max_filesize = 100 * 1024 -- 100 KB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
	return ok and stats and stats.size > max_filesize
end

isEnabled = function()
  if vim.api.nvim_get_mode().mode ~= 'i' then
    return false
  end

  if vim.fn.reg_recording() ~= '' or vim.fn.reg_executing() ~= '' then
    return false
  end

  local enabled = false
  enabled = enabled or (vim.api.nvim_get_option_value('buftype', { buf = 0 }) == 'prompt')
  enabled = enabled or require("cmp_dap").is_dap_buffer()
  enabled = enabled or not require('cmp.config.context').in_treesitter_capture('comment')
  return enabled
end

-- load luasnips + cmp related in insert mode only
return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", 'BufReadPre', 'BufNewFile' },
  condn = isEnabled,
  dependencies = {
    "L3MON4D3/LuaSnip", -- snippet plugin
    "windwp/nvim-autopairs", -- autopairing of (){}[] etc

    -- cmp sources plugins
    "hrsh7th/cmp-nvim-lua", -- for autocompletion support in nvim lua api config.

    "saadparwaiz1/cmp_luasnip",
    -- "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "FelipeLema/cmp-async-path",
    'hrsh7th/cmp-calc',
  },
  opts = function()
    -- completion suggestion line limit.
    vim.opt.pumheight = 14

    local function border(hl_name)
      return {
        { "╭", hl_name },
        { "─", hl_name },
        { "╮", hl_name },
        { "│", hl_name },
        { "╯", hl_name },
        { "─", hl_name },
        { "╰", hl_name },
        { "│", hl_name },
      }
    end

    -- local cmp_style = cmp_ui.style

    -- local field_arrangement = {
    --   atom = { "kind", "abbr", "menu" },
    --   atom_colored = { "kind", "abbr", "menu" },
    -- }

    local is_cmp_style_atom = (cmp_ui.style ~= "atom" and cmp_ui.style ~= "atom_colored")

    return {
      completion = {
        completeopt = "menu,menuone,noinsert",
      },

      window = {
        completion = {
          completeopt = "menu,menuone,noinsert",
          side_padding = is_cmp_style_atom and 1 or 0,
          winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
          scrollbar = true,
          border = (is_cmp_style_atom and border "CmpBorder") or options.window.completion.border
          -- border = border "CmpBorder"
        },
        documentation = {
          border = border "CmpDocBorder",
          winhighlight = "Normal:CmpDoc",
        },
      },

      formatting = {
        -- default fields order i.e completion word + item.kind + item.kind icons
        -- fields = field_arrangement[cmp_style] or { "kind", "abbr", "menu" },
        fields = { "kind", "abbr" },

        format = function(entry, item)
          -- To get vscode like autocompletions.
          -- item.menu = cmp_ui.lspkind_text and item.kind  or ""
          item.kind = cmp_ui.icons and (
            cmp_lsp_icons[item.kind] or cmp_custom_src_icons[entry.source.name] or ""
          )

          -- Old config
          -- local icons = require "nvchad.icons.lspkind"
          -- local icon = cmp_ui.lspkind_text and icons[item.kind]
          -- if is_cmp_style_atom then
          --   icon = " " .. icon .. " "
          --   item.menu = cmp_ui.lspkind_text and item.kind  or ""
          --   item.kind = icon
          -- else
          --   -- icon = cmp_ui.lspkind_text and (" " .. icon .. " ") or icon
          --   item.kind = string.format("%s %s", icon, cmp_ui.lspkind_text and item.kind or "")
          -- end
          return item
        end,
      },
      experimental = {
        ghost_text = true
      }
    }
  end,

  config = function(_, opts)
    dofile(vim.g.base46_cache .. "cmp")

    local cmp = require('cmp')

    -- Until https://github.com/hrsh7th/nvim-cmp/issues/1716
    -- (cmp.ConfirmBehavior.MatchSuffix) gets implemented, use this local wrapper
    -- to choose between `cmp.ConfirmBehavior.Insert` and
    -- `cmp.ConfirmBehavior.Replace`:
    local confirm = function(entry)
      local behavior = cmp.ConfirmBehavior.Replace
      if entry then
        local completion_item = entry.completion_item
        local newText = ''
        if completion_item.textEdit then
          newText = completion_item.textEdit.newText
        elseif type(completion_item.insertText) == 'string' and completion_item.insertText ~= '' then
          newText = completion_item.insertText
        else
          newText = completion_item.word or completion_item.label or ''
        end

        -- How many characters will be different after the cursor position if we replace?
        local diff_after = math.max(0, entry.replace_range['end'].character + 1) - entry.context.cursor.col

        -- Does the text that will be replaced after the cursor match the suffix
        -- of the `newText` to be inserted? If not, we should `Insert` instead.
        if entry.context.cursor_after_line:sub(1, diff_after) ~= newText:sub(-diff_after) then
          behavior = cmp.ConfirmBehavior.Insert
        end
      end
      cmp.confirm({ select = true, behavior = behavior })
    end

    local mapping = cmp.mapping.preset.insert{
      -- next suggestion
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<Down>'] = cmp.mapping.select_next_item(),

      -- previous suggestion
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<Up>'] = cmp.mapping.select_prev_item(),

      -- Scroll docs down
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),

      -- Scroll docs up
      ["<C-u>"] = cmp.mapping.scroll_docs(4),

      -- Show completion menu
      ["<C-Space>"] = cmp.mapping.complete(),

      -- Close suggestions window.
      ["<C-e>"] = cmp.mapping.close(),
      ["<Esc>"] = cmp.mapping.close(),

      ['<CR>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          confirm(entry)
        else
          fallback()
        end
      end, { 'i', 's' }),

      -- smart tabs to choose between suggestions and switch between fields in snippets.
      ["<Tab>"] = cmp.mapping(
        function(fallback)
          local luasnip = require("luasnip")
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }
      ),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        local luasnip = require("luasnip")
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }

    sources = cmp.config.sources({
        -- { name = 'calc' }, -- Suggest calculated results
        { name = "nvim_lsp" }, -- lsp
        { name = 'nvim_lua' },
        { name = "luasnip", max_item_count = 4 }, -- snippets
        -- { name = 'nvim_lsp_signature_help' },
        -- { name = "buffer" }, -- text within current buffer
        -- { name = "path" }, -- file system paths
        { name = 'async_path' },  -- file system paths

        -- From lazydev, set group index to 0 to skip loading LuaLS completions
        -- { name = "lazydev", group_index = 0 },
        -- { name = "dap" }, -- DAP REPL and UI completion
      }, {
        { name = 'buffer' }
      }
    )

    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    }

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
      sources = {
        { name = "dap" }
      },
    })

    vim.api.nvim_create_autocmd('BufReadPre', {
      callback = function(t)
        if not bufIsBig(t.buf) then
          sources[#sources+1] = { name = 'treesitter', group_index = 2 }
        end
        cmp.setup.buffer { sources = sources }
      end
    })

    opts.mapping = opts.mapping or mapping
    opts.sources = opts.sources or sources
    opts.snippet = opts.snippet or snippet

    local highlight = vim.api.nvim_set_hl

    -- vscode dark+ like colour theme for menu.
    -- gray
    highlight(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
    -- blue
    highlight(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
    highlight(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
    -- light blue
    highlight(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
    highlight(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
    highlight(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
    -- pink
    highlight(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
    highlight(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
    -- front
    highlight(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
    highlight(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
    highlight(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })

    cmp.setup(opts)
  end
}
