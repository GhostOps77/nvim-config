return {
  "NvChad/base46",
  branch = "v3.0",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- lazy = false
	},
  build = function()
    require("base46").load_all_highlights()
  end
}
