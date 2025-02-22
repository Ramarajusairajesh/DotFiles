-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.opt.relativenumber = false
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.showmatch = true
vim.opt.matchtime = 2
function Transparent()
	color = "tokyonight"
	vim.cmd.colorscheme(color)
	--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
end

local function make_backgrounds_transparent_except_visual()
	for _, group in pairs(vim.fn.getcompletion("", "highlight")) do
		local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
		hl.bg = "#000000" -- Make background transparent
		vim.api.nvim_set_hl(0, group, hl)
	end

	-- Set a distinct background color for Visual mode
	vim.api.nvim_set_hl(0, "Visual", { bg = "#FFFFFF", fg = "none" }) -- Replace #3B3F58 with your desired color
end

-- Apply transparency and Visual mode exception
make_backgrounds_transparent_except_visual()

-- NeoTree configuration
require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			visible = true, -- Show dotfiles
			hide_dotfiles = false, -- Allow dotfiles to be visible
			hide_gitignored = false, -- Optionally disable hiding gitignored files
		},
	},
})
-- Move to the end of the line with Alt+e
vim.api.nvim_set_keymap("n", "<A-e>", "$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-e>", "<C-o>$", { noremap = true, silent = true })

-- Move to the beginning of the line with Alt+b
vim.api.nvim_set_keymap("n", "<A-b>", "^", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-b>", "<C-o>^", { noremap = true, silent = true })

-- Move one word to the left with Alt+h
vim.api.nvim_set_keymap("n", "<A-h>", "b", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-h>", "<C-o>b", { noremap = true, silent = true })

-- Move one word to the right with Alt+l
vim.api.nvim_set_keymap("n", "<A-l>", "w", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<A-l>", "<C-o>w", { noremap = true, silent = true })

-- Ctrl+o for horizontal split
vim.api.nvim_set_keymap("n", "<C-o>", ":split<CR>", { noremap = true, silent = true })

-- Ctrl+e for vertical split
vim.api.nvim_set_keymap("n", "<C-e>", ":vsplit<CR>", { noremap = true, silent = true })
-- Ctrl+q to close the current pane (window)
vim.api.nvim_set_keymap("n", "<C-q>", ":q<CR>", { noremap = true, silent = true })

-- Scroll full screen down with Ctrl-u
vim.api.nvim_set_keymap("n", "<C-u>", "<C-f>", { noremap = true, silent = true })

-- Scroll full screen up with Ctrl-d
vim.api.nvim_set_keymap("n", "<C-d>", "<C-b>", { noremap = true, silent = true })

-- Scroll half screen down with Ctrl-f
vim.api.nvim_set_keymap("n", "<C-f>", "<C-d>", { noremap = true, silent = true })

-- Scroll half screen up with Ctrl-b
vim.api.nvim_set_keymap("n", "<C-b>", "<C-u>", { noremap = true, silent = true })

vim.opt.clipboard = "unnamedplus"

-- Swap the current pane with the one to the left
vim.api.nvim_set_keymap("n", "<A-h>", "<C-w>H", { noremap = true, silent = true })

-- Swap the current pane with the one to the right
vim.api.nvim_set_keymap("n", "<A-l>", "<C-w>L", { noremap = true, silent = true })

-- Swap the current pane with the one above
vim.api.nvim_set_keymap("n", "<A-K>", "<C-w>K", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<A-J>", "<C-w>J", { noremap = true, silent = true })
-- Swap the current pane with the one belowright

-- Function to toggle Netrw (open or close)

-- Function to toggle Netrw (open or close) without quitting Neovim
function ToggleNetrw()
	-- Check if Netrw is already open (by checking the window's filetype)
	if vim.bo.filetype == "netrw" then
		-- If Netrw is open, go back to the previous file (previous buffer)
		vim.cmd("bprevious")
	else
		-- If Netrw is not open, save the current file and open Netrw
		vim.cmd("w")
		vim.cmd("Explore")
	end
end

-- Map Ctrl+I to toggle Netrw
vim.api.nvim_set_keymap("n", "<C-i>", ":lua ToggleNetrw()<CR>", { noremap = true, silent = true })
-- Function to toggle fullscreen for the current split pane

-- Variable to track fullscreen state
local is_fullscreen = false

-- Function to toggle fullscreen for the current split pane
function ToggleFullscreen()
	if is_fullscreen then
		-- If already fullscreen, return to normal split layout
		vim.cmd("wincmd =") -- Equalize all splits
		is_fullscreen = false
	else
		-- If not fullscreen, maximize the current pane
		vim.cmd("wincmd _") -- Maximize vertically
		vim.cmd("wincmd |") -- Maximize horizontally
		is_fullscreen = true
	end
end

-- Map Ctrl+Z to toggle fullscreen for the current pane
vim.api.nvim_set_keymap("n", "<C-z>", ":lua ToggleFullscreen()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-q>", ":bd<CR>", { noremap = true, silent = true, desc = "Close buffer" })

-- Enclocing text with brackets and quotes

-- Key mappings for enclosing selected text in visual mode
local opts = { noremap = true, silent = true }

-- Enclose selection with quotes, brackets, or parentheses
vim.keymap.set("x", "'", "c''<Esc>P", opts)
vim.keymap.set("x", '"', 'c""<Esc>P', opts)
vim.keymap.set("x", "`", "c``<Esc>P", opts)
vim.keymap.set("x", "(", "c()<Esc>P", opts)
vim.keymap.set("x", "[", "c[]<Esc>P", opts)
vim.keymap.set("x", "{", "c{}<Esc>P", opts)

-- Continue to select text in visual mode when pressed alt+e and alt+b to go to the beginning and ending of the paragraph
vim.keymap.set("v", "<M-e>", "o$") -- Extend selection to end of the line
vim.keymap.set("v", "<M-b>", "o^") -- Extend selection to beginning of the line

--Man page

vim.g.man_hardwrap = 0 -- Prevents wrapping
vim.api.nvim_create_autocmd("FileType", {
	pattern = "man",
	command = "wincmd o", -- Closes all other windows when opening a man page
})

-- Undo tree keybinding
vim.keymap.set("n", "<A-Z>", "<cmd>Telescope undo<cr>", { desc = "Undo history" })

--Exit nvim close all files
vim.keymap.set("n", "<A-q>", "<cmd>q<cr>", { desc = "Exit Neovim" })

-- Show docs for the highlighted function or the function under the cursor
vim.keymap.set({ "n", "v" }, "q", function()
	local ft = vim.bo.filetype
	if vim.tbl_contains({ "vim", "help" }, ft) then
		vim.cmd("h " .. vim.fn.expand("<cword>"))
	elseif vim.lsp.buf and vim.lsp.buf.hover then
		vim.lsp.buf.hover()
	else
		print("No documentation available")
	end
end, { silent = true, desc = "Show Documentation" })
