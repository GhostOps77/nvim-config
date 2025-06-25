return {
  "nvchad/ui",
  branch = 'v3.0',
  lazy = false,
  config = function()
		require "nvchad"

		-- load base46 cache for nvchad theme
		dofile(vim.g.base46_cache .. "statusline")
		dofile(vim.g.base46_cache .. "defaults")
  end
}
