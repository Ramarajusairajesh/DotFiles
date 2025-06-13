return {
	"mbbill/undotree",
	cmd = { "UndotreeToggle", "UndotreeShow" },
	keys = {
		{ "<leader>U", "<cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
	},
	config = function()
		-- Optional: always open the tree on the right
		vim.g.undotree_WindowLayout = 2
		-- Optional: focus on the tree when opened
		vim.g.undotree_SetFocusWhenToggle = 1
	end,
}
