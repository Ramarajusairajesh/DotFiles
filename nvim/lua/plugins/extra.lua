return {
	{
		"andymass/vim-matchup",
		event = "VeryLazy",
		config = function()
			vim.g.matchup_matchparen_deferred = 1 -- Highlight matching pairs asynchronously
			vim.g.matchup_matchparen_offscreen = { method = "popup" } -- Show match when offscreen
		end,
	},
}
