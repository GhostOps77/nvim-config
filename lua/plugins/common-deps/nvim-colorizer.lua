return {
  "NvChad/nvim-colorizer.lua",
  config = function(_, opts)
    -- execute colorizer as soon as possible
    vim.defer_fn(function()
      require("colorizer").attach_to_buffer(0)
    end, 0)
  end,
}
