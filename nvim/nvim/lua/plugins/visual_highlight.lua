-- ~/.config/nvim/lua/plugins/visual_highlight.lua
return {
	{
		-- No plugin dependency, just our highlight feature
		-- We'll load it immediately since it’s lightweight
		"nvim-lua/plenary.nvim", -- a dummy plugin to keep Lua format
		lazy = false,
		config = function()
			-- Define highlight groups
			vim.api.nvim_set_hl(0, "BlueText", { fg = "#0000ff" })
			vim.api.nvim_set_hl(0, "RedText", { fg = "#ff0000" })
			vim.api.nvim_set_hl(0, "YellowText", { fg = "#ffff00" })

			vim.api.nvim_set_hl(0, "BlueBg", { bg = "#0000ff" })
			vim.api.nvim_set_hl(0, "RedBg", { bg = "#ff0000" })
			vim.api.nvim_set_hl(0, "YellowBg", { bg = "#ffff00" })

			vim.api.nvim_set_hl(0, "BoldText", { bold = true })

			-- Helper to get visual selection
			local function get_visual_range()
				local start_pos = vim.fn.getpos("'<")
				local end_pos = vim.fn.getpos("'>")
				local start_row, start_col = start_pos[2] - 1, start_pos[3] - 1
				local end_row, end_col = end_pos[2] - 1, end_pos[3] - 1
				return start_row, start_col, end_row, end_col
			end

			-- Helper to apply highlight
			function _G.apply_highlight(hl_group)
				local bufnr = vim.api.nvim_get_current_buf()
				local start_row, start_col, end_row, end_col = get_visual_range()
				local ns = vim.api.nvim_create_namespace("visual_highlight")
				vim.api.nvim_buf_add_highlight(bufnr, ns, hl_group, start_row, start_col, end_col + 1)
				if end_row > start_row then
					for l = start_row + 1, end_row - 1 do
						vim.api.nvim_buf_add_highlight(bufnr, ns, hl_group, l, 0, -1)
					end
					vim.api.nvim_buf_add_highlight(bufnr, ns, hl_group, end_row, 0, end_col + 1)
				end
			end

			-- Alt+h to choose foreground color
			vim.keymap.set("v", "<A-h>", function()
				vim.ui.input({ prompt = "Choose color: (b)lue, (r)ed, (y)ellow, (g)reen: " }, function(choice)
					if choice == "b" then
						apply_highlight("BlueText")
					elseif choice == "r" then
						apply_highlight("RedText")
					elseif choice == "y" then
						apply_highlight("YellowText")
					end
				end)
			end, { noremap = true, silent = true, desc = "Highlight (fg) selected text" })

			-- Ctrl+b to choose background color
			vim.keymap.set("v", "<C-b>", function()
				vim.ui.input({ prompt = "Choose background: (b)lue, (r)ed, (y)ellow: " }, function(choice)
					if choice == "b" then
						apply_highlight("BlueBg")
					elseif choice == "r" then
						apply_highlight("RedBg")
					elseif choice == "y" then
						apply_highlight("YellowBg")
					end
				end)
			end, { noremap = true, silent = true, desc = "Highlight (bg) selected text" })

			-- Ctrl+[ to make text bold
			-- vim.keymap.set("v", "<C-[>", function()
			-- 	apply_highlight("BoldText")
			-- end, { noremap = true, silent = true, desc = "Make selected text bold" })
			--
			-- <leader>ch to clear all highlights
			vim.keymap.set("n", "<leader>ch", function()
				local ns = vim.api.nvim_create_namespace("visual_highlight")
				vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
			end, { noremap = true, silent = true, desc = "Clear all highlights" })
		end,
	},
}
