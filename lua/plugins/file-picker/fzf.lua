return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter"
  },
  opts = {
    files = {
      formatter = "path.filename_first",
    }
  },
  config = function(_, opts)
    local table = { 'telescope' }

    for k, v in pairs(opts) do
      table[k] = v
    end

    require('fzf-lua').setup(table)
  end
}
