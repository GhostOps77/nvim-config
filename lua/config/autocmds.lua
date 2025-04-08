-- require "nvchad.autocmds"

-- local autocmd = vim.api.nvim_create_autocmd

-- user event that loads after UIEnter + only if file buf is there
-- autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
--   group = vim.api.nvim_create_augroup("NvFilePost", { clear = true }),
--   callback = function(args)
--     local file = vim.api.nvim_buf_get_name(args.buf)
--     local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

--     if not vim.g.ui_entered and args.event == "UIEnter" then
--       vim.g.ui_entered = true
--     end

--     if file ~= "" and buftype ~= "nofile" and vim.g.ui_entered then
--       vim.api.nvim_exec_autocmds("User", { pattern = "FilePost", modeline = false })
--       vim.api.nvim_del_augroup_by_name "NvFilePost"

--       vim.schedule(function()
--         vim.api.nvim_exec_autocmds("FileType", {})

--         if vim.g.editorconfig then
--           require("editorconfig").config(args.buf)
--         end
--       end)
--     end
--   end,
-- })


-- autocmd("FileType", {
--   pattern = "qf",
--   callback = function()
--     vim.opt_local.buflisted = false
--   end,
-- })

-- -- Copy yanked text to windows clipboard if on WSL
-- if vim.fn.has("wsl") == 1 then
--   autocmd("TextYankPost", {
--     callback = function()
--       vim.schedule(function()
--         vim.fn.system("clip.exe", vim.fn.getreg("0"))
--       end)
--     end,
--   })
-- end

-- -- sync with system clipboard on focus fain
-- autocmd({ "FocusGained" }, {
--   pattern = { "*" },
--   command = [[call setreg("@", getreg("+"))]],
-- })


-- -- sync with system clipboard on focus lost
-- autocmd({ "FocusLost" }, {
--   pattern = { "*" },
--   command = [[call setreg("+", getreg("@"))]], 
-- })
