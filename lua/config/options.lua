-- require "nvchad.options"

local opt = vim.opt
local g = vim.g

-- local is_windows = vim.fn.has "win32" ~= 0
-- local is_wsl = vim.fn.has("wsl") == 1
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"

local tab_width = 2

-------------------------------------- globals -----------------------------------------
g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
g.toggle_theme_icon = "   "
g.have_nerd_font = true
g.mapleader = " "

-- remove default auto indentation for python files. 
g.python_recommended_style = 0

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  g["loaded_" .. provider .. "_provider"] = 0
end

-------------------------------------- options ------------------------------------------
-- Session options
-- opt.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

opt.laststatus = 3 -- global statusline
opt.showmode = false

-- column limit indicator
opt.colorcolumn = { 90, 120 }

-- old config
-- opt.clipboard:append("unnamedplus")

-- syncing clipboard slows down nvim startup.
-- Thus, this is deferred.
vim.schedule(function()
  -- vim.opt.clipboard = 'unnamedplus'
  opt.clipboard:append("unnamedplus")
end)
-- opt.clipboard = ""
opt.cursorline = true

-- Indenting
opt.tabstop = tab_width
opt.shiftwidth = tab_width
opt.softtabstop = tab_width
opt.expandtab = false -- Use tabs instead of spaces
opt.autoindent = true
opt.smartindent = true

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Line Numbers
-- opt.relativenumber = true
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- Consider - as part of keyword
opt.iskeyword:append("-")

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
-- opt.background = "dark"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400

-- This doesn't delete changes history even after saving and closing the file
-- opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- add binaries installed by mason.nvim to path
vim.env.PATH = table.concat({ vim.fn.stdpath "data", "mason", "bin" }, sep) .. delim .. vim.env.PATH

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- adds dos fileformat type to get rid of ^M at the end of each line, which has \r\n
-- at the end, instead of \n (that file is most likely to be from windows)
-- vim.cmd "edit ++ff=dos"

-- vim.o.winbar = '%=%m %f'

-- function conditional_winbar()
--   local bufnr = vim.api.nvim_get_current_buf()
--   local fname = vim.fn.expand("%:t")

--   -- Check: non-empty buffer, listed, has filename
--   if vim.bo[bufnr].buftype == "" and vim.bo[bufnr].buflisted and fname ~= "" then
--     return fname .. " %m"
--   else
--     return ""
--   end
-- end

-- vim.o.winbar = "%{%v:lua.conditional_winbar()%}"
