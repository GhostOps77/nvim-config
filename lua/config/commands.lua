local new_cmd = vim.api.nvim_create_user_command

-- new_cmd("NvChadUpdate", function()
--   require "nvchad.updater"()
-- end, {})

new_cmd('RemoveCR', function()
  vim.cmd "%s/\r\n/\n/g"
end, {})
