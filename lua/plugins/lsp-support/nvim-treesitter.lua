return {
  "nvim-treesitter/nvim-treesitter",
  event = { 'BufRead', 'BufNewFile' },
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      -- "vim",
      -- "vimdoc",
      "lua",
      "luadoc",
      -- "printf",
      -- "html",
      -- "css",
      -- "javascript",
      -- "typescript",
      -- "tsx",
      -- "c",
      "markdown",
      "markdown_inline",
      "python"
    },
    highlight = {
      enable = true,
      use_languagetree = true,
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 kb
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        return ok and stats and stats.size > max_filesize
      end
    },
    filesystem_watchers = {
      ignore_dirs = {
        "node_modules", "venv"
      },
    },
    auto_install = true,
    indent = { enable = true },
    additional_vim_regex_highlighting = false
  },
  config = function(_, opts)
    dofile(vim.g.base46_cache .. "syntax")
    dofile(vim.g.base46_cache .. "treesitter")

    require("nvim-treesitter.configs").setup(opts)
  end,
}
