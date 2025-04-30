-- Default mappings
-- require "nvchad.mappings"

local map = vim.keymap.set

----------------------------------- general keymaps --------------------------------------
-- easy way to enter command mode
map("n", ";", ":", { desc = "CMD enter command mode", nowait = true })

-- ctrl + backspace to delete the previous word
-- map('i', "<C-BS>", "<C-w>", { desc = "Delete the previous word" })
map('i', '<C-BS>', '<C-o>dw', { desc = "Delete the previous word" })

-- go to  beginning and end
map("i", "<C-b>", "<ESC>^i", { desc = "Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "End of line" })

-- navigate within insert mode
map("i", "<C-h>", "<Left>", { desc = "Move left" })
map("i", "<C-l>", "<Right>", { desc = "Move right" })
map("i", "<C-j>", "<Down>", { desc = "Move down" })
map("i", "<C-k>", "<Up>", { desc = "Move up" })

-- switch between windows
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })

-- map("n", "<C-s>", "<cmd> w <CR>", { desc = "Save file" })
-- map("n", "<C-c>", "<cmd> %y+ <CR>", { desc = "Copy whole file" })
-- map("n", "<leader>n", "<cmd> set nu! <CR>", { desc = "Toggle line number" })
-- map("n", "<leader>rn", "<cmd> set rnu! <CR>", { desc = "Toggle relative number" })

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using <cmd> :map
-- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
map("n", "k", 'v:count == 0 ? "gk" : "k"', { desc = "Move up", expr = true })
map("n", "j", 'v:count == 0 ? "gj" : "j"', { desc = "Move down", expr = true })
map({"n", "v", "x"}, "<Up>", 'v:count == 0 ? "gk" : "k"', { desc = "Move up", expr = true })
map({"n", "v", "x"}, "<Down>", 'v:count == 0 ? "gj" : "j"', { desc = "Move down", expr = true })

map("n", "<leader>nb", "<cmd> enew <CR>", { desc = "New buffer" })

map("n", "<leader>ch", "<cmd> NvCheatsheet <CR>", { desc = "Mapping cheatsheet" })

map({"n", "v"}, "<leader>fm", function()
  vim.lsp.buf.format { async = true }
end, { desc = "LSP formatting" })

-- indentation
map("v", "<", "<gv", { desc = "Indent line" })
map("v", ">", ">gv", { desc = "Indent line" })

-- Don't copy the replaced text after pasting in visual mode
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
map("x", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', { desc = "Dont copy replaced text", silent = true })

-- themes switcher
map("n", "<leader>ts", function()
  require("nvchad.themes").open {
    mappings = function(buf)
      map("i", "<C-k>", require("nvchad.themes.api").move_up, { buffer = buf })
      map("i", "<C-j>", require("nvchad.themes.api").move_down, { buffer = buf })
    end,
  }
end, { desc = "NvChad themes switcher" })

----------------------------------- Tabufline -------------------------------------------
-- cycle through buffers
map("n", "<tab>", function()
  require("nvchad.tabufline").next()
end, { desc = "Goto next buffer" })

map("n", "<S-tab>", function()
  require("nvchad.tabufline").prev()
end, { desc = "Goto prev buffer" })

-- close buffer + hide terminal buffer
map("n", "<leader>x", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "Close buffer" })

map('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })  -- New tab
map('n', '<leader>tw', ':tabclose<CR>', { noremap = true, silent = true })  -- Close tab
map('n', '<leader>tl', 'gt', { noremap = true, silent = true })  -- Next tab
map('n', '<leader>th', 'gT', { noremap = true, silent = true })  -- Previous tab


------------------------------------- Comment --------------------------------------------
-- -- toggle comment in both modes
-- map("n", "<leader>/", function()
--     require("Comment.api").toggle.linewise.current()
--   end, { desc = "Toggle comment" })

-- map("v", "<leader>/",
--   "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
--   { desc = "Toggle comment" })

-- replaced by neovim's builtin commenting feature, mentioned below.

map("n", "<leader>/", "gcc", { desc = "Toggle comment", nowait = true, remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", nowait = true, remap = true })

---------------------------------------- lspconfig--- ------------------------------------
-- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions
map("n", "gD", vim.lsp.buf.declaration, { desc = "LSP declaration" })
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP definition" })
map("n", "K", vim.lsp.buf.hover, { desc = "LSP hover" })
-- map("n", "gi", vim.lsp.buf.implementation, { desc = "LSP implementation" })
-- map("n", "<leader>sh", vim.lsp.buf.signature_help, { desc = "LSP signature help" })
map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "LSP definition type" })
-- map({ "n", 'v' }, "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })
-- map("n", "gr", vim.lsp.buf.references, { desc = "LSP references" })

map("n", "<leader>ra", function() -- LSP renamer from nvchad.
  require("nvchad.lsp.renamer")()
end, { desc = "LSP rename" })

map("n", "<leader>lf", function()
    vim.diagnostic.open_float { border = "rounded" }
  end, { desc = "Floating diagnostic" }
)
map("n", "[d", function()
    vim.diagnostic.goto_prev { float = { border = "rounded" } }
  end, { desc = "Goto prev" }
)
map("n", "]d", function()
    vim.diagnostic.goto_next { float = { border = "rounded" } }
  end, { desc = "Goto next" }
)
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic setloclist" })

map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "Add workspace folder" })
map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "Remove workspace folder" })

map("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "List workspace folders" })

map("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP code action" })

--------------------------------------------- NvimTree -----------------------------------
map("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })
map("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { desc = "Focus nvimtree" })
-- map('n', '<C-')

--------------------------------------------- Telescope -----------------------------------
-- -- find
-- map("n", "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Find all" })
-- map("n", "<leader>fh", "<cmd> Telescope help_tags <CR>", { desc = "Help page" })

-- -- pick a hidden term
-- map("n", "<leader>pt", "<cmd> Telescope terms <CR>", { desc = "Pick hidden term" })

-- map("n", "<leader>ma", "<cmd> Telescope marks <CR>", { desc = "Telescope bookmarks" })

-------------------------------------------- fzf lua -------------------------------------
-- find
-- map("n", "<leader>fa", "<cmd> FzfLua find_files follow=true no_ignore=true hidden=true <CR>", { desc = "Find all" })
-- map("n", "<leader>fw", "<cmd> FzfLua live_grep <CR>", { desc = "Live grep" })

map("n", "<leader>ff", function()
  require('fzf-lua').files()
end, { desc = "Find files" })

map("n", "<leader>fw", function()
  require('fzf-lua').live_grep_native()
end, { desc = "Live grep" })

map("n", "<leader>fb", function()
  require('fzf-lua').buffers()
end, { desc = "Find buffers" })

map("n", "<leader>fh", function()
  require('fzf-lua').helptags()
end, { desc = "Help page" })

map("n", "<leader>fo", function()
  require('fzf-lua').oldfiles()
end, { desc = "Find oldfiles" })

map("n", "<leader>fz", function()
  require('fzf-lua').lgrep_curbuf()
end, { desc = "Find in current buffer" })

-- git
map("n", "<leader>cm", function()
  require('fzf-lua').git_commits()
end, { desc = "Git commits" })

map("n", "<leader>gt", function()
  require('fzf-lua').git_status()
end, { desc = "Git status" })

map({ "n", "v", "i" }, "<C-x><C-f>", function()
  require("fzf-lua").complete_path()
end, { silent = true, desc = "Fuzzy complete path" })

-- theme switcher
-- map("n", "<leader>th", "<cmd> FzfLua themes switcher <CR>", { desc = "Nvchad themes" })

----------------------------------------- nvchad term ------------------------------------
-- terminal

-- I have no idea what this below line is used for. But it's used here anyway.
-- But acc. to the docs, it changes terminal char codes into normal char codes.
-- eg., <CR> are replaced with \r.
vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true)

-- easy escape
map("t", "<Esc>", "<C-\\><C-N>", { desc = "Escape terminal mode" })

-- new terminals
map("n", "<leader>th", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "New horizontal terminal" })

map("n", "<leader>tv", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "New vertical terminal" })

-- toggle terminal preview
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "Toggle vertical terminal" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "Toggle horizontal terminal" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Toggle floating terminal" })

-------------------------------------- whichkey ------------------------------------------

map("n", "<leader>wK", function()
  vim.cmd "WhichKey"
end, { desc = "Which-key all keymaps" })

map("n", "<leader>wk", function()
  local input = vim.fn.input "WhichKey: "
  vim.cmd("WhichKey " .. input)
end, { desc = "Which-key query lookup" })

--------------------------------- indent blankline ---------------------------------------
-- Jump to current context
-- map('n', '<leader>cc', function()
--   local ok, start = require('indent_blankline.utils').get_current_context(
--     vim.g.indent_blankline_context_patterns,
--     vim.g.indent_blankline_use_treesitter_scope
--   )

--   if ok then
--     vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win() { start, 0 })
--     vim.cmd([[normal! _]])
--   end
-- end, { desc = 'Jump to current context' })

------------------------------------ conform ---------------------------------------------
map("n", "<leader>fm", function()
  require("conform").format()
end, { desc = "formatting" })

-- Remove any highlighting from previous regex search.
-- https://stackoverflow.com/a/1037182/16693888
map("n", "<Esc>", "<cmd> noh <CR>", { desc = "Clear highlights", silent = true })

----------------------------------------- nvzone/menu ------------------------------------

-- map({ "n", "v" }, "<RightMouse>", function()
--   if not package.loaded.menu then
--     return
--   end

--   require('menu.utils').delete_old_menus()

--   vim.cmd.exec '"normal! \\<RightMouse>"'

--   -- clicked buf
--   local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
--   local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

--   require("menu").open(options, { mouse = true })
-- end)

-- map({ "n", "v" }, "<LeftMouse>", function()
--   if not package.loaded.menu then
--     return
--   end

--   require('menu.utils').delete_old_menus()

--   vim.cmd.exec '"normal! \\<LefttMouse>"'

--   -- clicked buf
--   local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
--   local options = vim.bo[buf].ft == "NvimTree" and "nvimtree" or "default"

--   require("menu").open(options, { mouse = true })
-- end)

-- map({ "n", "v" }, "<ESC>", function ()
--   require('menu.utils').delete_old_menus()
-- end)

---------------------------------- treesitter-context ------------------------------------

-- map("n", "[c", function()
--   require("treesitter-context").go_to_context(vim.v.count1)
-- end, { silent = true })


-------------------------------------- Debugging -----------------------------------------
-- Breakpoints
map("n", "<leader>bb", function()
  require('dap').toggle_breakpoint()
end, { desc = "DEBUG Toggle breakpoint" })

map("n", "<leader>bc", function()
  require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = "DEBUG Set conditional breakpoint" })

map("n", "<leader>bl", function()
  require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, { desc = "DEBUG Set breakpoint with log msg" })

map("n", '<leader>br', function()
  require('dap').clear_breakpoints()
end, { desc = "DEBUG Clear breakpoints" })

map("n", '<leader>ba', function()
  require('fzf-lua').dap_breakpoints()
end, { desc = "DEBUG List all breakpoints" })

-- Debugger
map("n", "<leader>dc", function()
  local dap = require('dap')
  if dap.session() then
    dap.continue()
  end
end, { desc = "Continue/Start debugger" } )

map("n", "<leader>dj", function()
  local dap = require('dap')
  if dap.session() then
    dap.step_over()
  end
end, { desc = 'DEBUG Step over' })

map("n", "<leader>dk", function()
  local dap = require('dap')
  if dap.session() then
    dap.step_into()
  end
end, { desc = 'DEBUG Step in' })

map("n", "<leader>do", function()
  local dap = require('dap')
  if dap.session() then
    dap.step_out()
  end
end, { desc = 'DEBUG Step out' })

map("n", '<leader>dd', function()
  local dap = require('dap')
  if dap.session() then
    dap.disconnect()
    require('dapui').close()
  end
end, { desc = 'Disconnect from debugger' })

map("n", '<leader>dt', function()
  local dap = require('dap')
  if dap.session() then
    dap.terminate()
    require('dapui').close()
  end
end, { desc = 'Terminate debugger' })

map("n", "<leader>dr", function()
  local dap = require('dap')
  if dap.session() then
    dap.repl.toggle()
  end
end, { desc = 'DEBUG Toggle repl' })

map("n", "<leader>dl", function()
  local dap = require('dap')
  if dap.session() then
    dap.run_last()
  end
end, { desc = "DEBUG Run last" })

map("n", '<leader>di', function()
  if require('dap').session() then
    require("dap.ui.widgets").hover()
  end
end, { desc = 'DEBUG get variable info' })

map("n", '<leader>d?', function()
  if package.loaded.dap then
    local widgets = require("dap.ui.widgets")
    widgets.centered_float(widgets.scopes)
  end
end)

map("n", '<leader>df', function()
  require('fzf-lua').dap_frames()
end, { desc = 'DEBUG List stack frames' })

map("n", '<leader>dh', function()
  require('fzf-lua').dap_commands()
end, { desc = 'DEBUG List DAP commands' })


map("n", '<leader>de', function()
  require('nio').ui.select({ 'Document', 'Workspace' }, {
    prompt = 'On what do you want to run diagnostics? '
  }, function(choice)
    if choice == 'Document' then
      require('fzf-lua').diagnostics_document()--({default_text=":E:"})
    elseif choice == 'Workspace' then
      require('fzf-lua').diagnostics_workspace()--({default_text=":E:"})
    end
  end)
end, { desc = "Diagnostics current document/workspace" })
