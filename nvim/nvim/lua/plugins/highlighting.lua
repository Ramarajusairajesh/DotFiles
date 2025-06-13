return {
	{
		"inkarkat/vim-mark",
		event = "VeryLazy",
		init = function()
			-- Disable default mappings to avoid conflicts
			vim.g.mw_no_mappings = 1
		end,
		config = function()
			-- Map Alt+h to mark the word under cursor
			vim.keymap.set("n", "<A-h>", "<Plug>MarkSet", { desc = "Mark word (vim-mark)", silent = true })
		end,
	},
}
