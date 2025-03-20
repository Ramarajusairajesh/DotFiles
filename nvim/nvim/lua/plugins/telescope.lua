return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"debugloop/telescope-undo.nvim",
	},
	config = function()
		require("telescope").setup({
			extensions = {
				undo = {},
			},
		})
		require("telescope").load_extension("undo")
	end,
}
