return {
	"tpope/vim-fugitive",
	config = function()
		local keymap = vim.keymap.set
		local opts = { noremap = true, silent = true, desc = "Fugitive" }

		-- Main Git status (fugitive dashboard)
		keymap("n", "<leader>g", "<cmd>Git<CR>", vim.tbl_extend("force", opts, { desc = "Git status" }))

		-- Additional handy fugitive commands
		keymap("n", "<leader>gg", "<cmd>Git<CR>", vim.tbl_extend("force", opts, { desc = "Git status" }))
		keymap(
			"n",
			"<leader>gd",
			"<cmd>Gvdiffsplit!<CR>",
			vim.tbl_extend("force", opts, { desc = "Git diff (vertical)" })
		)
		keymap("n", "<leader>gb", "<cmd>Git blame<CR>", vim.tbl_extend("force", opts, { desc = "Git blame" }))
		keymap("n", "<leader>gc", "<cmd>Git commit<CR>", vim.tbl_extend("force", opts, { desc = "Git commit" }))
		keymap("n", "<leader>gp", "<cmd>Git push<CR>", vim.tbl_extend("force", opts, { desc = "Git push" }))
		keymap("n", "<leader>gl", "<cmd>Git pull<CR>", vim.tbl_extend("force", opts, { desc = "Git pull" }))
		keymap("n", "<leader>gs", "<cmd>Git<CR>", vim.tbl_extend("force", opts, { desc = "Git status" }))
	end,
}
