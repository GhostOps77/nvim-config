return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter"
  },
  config = function(_, opts)
    require('fzf-lua').setup({ 'telescope' })
  end
}
