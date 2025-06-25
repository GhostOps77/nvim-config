vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "config.lazy"

-- load plugins
require("lazy").setup({
  { import = "plugins" },
  { import = "plugins.autocompletion" },
  { import = "plugins.common-deps" },
  { import = "plugins.debugging" },
  { import = "plugins.file-picker" },
  { import = "plugins.formatting" },
  { import = "plugins.linting" },
  { import = "plugins.lsp-support" },
  { import = "plugins.mason-tools" },
  { import = "plugins.nvchad" },
  { import = "plugins.QoL" },
}, lazy_config)

-- load other configs
require "config.options"
require "config.keymaps"

vim.schedule(function()
  require "config.autocmds"
  require "config.commands"
end)
