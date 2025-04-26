-- git stuff

return {
  "lewis6991/gitsigns.nvim",
  enabled = false,
  ft = { "gitcommit", "diff" },
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "󰍵" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "│" },
    },
  },
  keys = {
    { -- Navigation through hunks
      ']c', function()
        if vim.wo.diff then
          return ']c'
        end
        package.loaded.gitsigns.next_hunk()
        return '<Ignore>'
      end,
      desc = 'Jump to next hunk', expr = true
    },
    {
      '[c', function()
        if vim.wo.diff then
          return '[c'
        end
        package.loaded.gitsigns.next_hunk()
        return '<Ignore>'
      end, desc = 'Jump to prev hunk', expr = true
    },

    -- Actions
    {
      '<leader>rh', function()
        package.loaded.gitsigns.reset_hunk()
      end, desc = 'Reset hunk'
    },
    {
      '<leader>ph', function()
        package.loaded.gitsigns.preview_hunk()
      end, desc = 'Preview hunk'
    },
    {
      '<leader>gb', function()
        package.loaded.gitsigns.blame_line()
      end, desc = 'Blame line'
    },
    {
      '<leader>td', function()
        package.loaded.gitsigns.toggle_deleted()
      end, desc = 'Toggle deleted'
    }
  },
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "git")

    -- load gitsigns only when a git file is opened
    vim.api.nvim_create_autocmd({ "BufRead" }, {
      group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
      callback = function()
        vim.fn.jobstart({"git", "-C", vim.loop.cwd(), "rev-parse"}, {
          on_exit = function(_, return_code)
            if return_code == 0 then
              vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
              vim.schedule(function()
                require("lazy").load { plugins = { "gitsigns.nvim" } }
              end)
            end
          end
        })
      end,
    })
  end,
}
