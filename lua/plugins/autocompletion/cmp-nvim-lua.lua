local is_windows = vim.fn.has "win32" ~= 0

return {
  -- for autocompletion support in nvim lua api config.
  "hrsh7th/cmp-nvim-lua",
  ft = 'lua',
  condn = function()
    local file_path = vim.fn.expand("%:p")
    local config_path = vim.fn.expand(
      is_windows and "%LocalAppData%/nvim/" -- C:/Users/Mouhsen/AppData/Local/nvim
      or "~/.config/nvim/"
    )
    return file_path:find(vim.pesc(config_path), 1, true)
  end
}