-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("plugins.java_init")
vim.opt.relativenumber = false
vim.cmd("filetype plugin indent on")
-- Set tab width to 8 spaces
vim.opt.tabstop = 8
vim.opt.softtabstop = 8
vim.opt.shiftwidth = 8
vim.opt.expandtab = false

vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.termguicolors = true
vim.opt.wrap = true
vim.keymap.set("n", "xx", "dd", { noremap = true })

function Transparent()
	color = "tokyonight"
	vim.cmd.colorscheme(color)
	--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

local function make_backgrounds_transparent_except_visual()
	for _, group in pairs(vim.fn.getcompletion("", "highlight")) do
		local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
		hl.bg = "none" -- Make background transparent
		vim.api.nvim_set_hl(0, group, hl)
	end

	-- Set a distinct background color for Visual mode
	vim.api.nvim_set_hl(0, "Visual", { bg = "#888a89", fg = "none" }) -- Replace #3B3F58 with your desired color
end

-- Apply transparency and Visual mode exception
make_backgrounds_transparent_except_visual()

-- NeoTree configuration
require("neo-tree").setup({
	window = {
		position = "right", -- Move Neo-tree to the right
	},
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

-- Function to toggle Netrw (open or close) without quitting Neovim

function ToggleNetrw()
	-- Check if Netrw is open in any window
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "netrw" then
			-- Close the Netrw window
			vim.api.nvim_win_close(win, true)
			return
		end
	end

	-- If Netrw is not open, save the current file and open Netrw
	vim.cmd("w") -- Save the file
	vim.cmd("Explore")
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
vim.keymap.set("x", "<", "c<><Esc>P", opts)

-- Continue to select text in visual mode when pressed alt+e and alt+b to go to the beginning and ending of the paragraph
vim.keymap.set("v", "<M-e>", "o$") -- Extend selection to end of the line
vim.keymap.set("v", "<M-b>", "o^") -- Extend selection to beginning of the line

vim.keymap.set("n", "<A-L>", "<cmd>vertical resize -3<CR>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<A-H>", "<cmd>vertical resize +2<CR>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<A-J>", "<cmd>horizontal resize +2<CR>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<A-K>", "<cmd>horizontal resize -2<CR>", { desc = "Increase Window Height" })

--Man page

vim.g.man_hardwrap = 0 -- Prevents wrapping
vim.api.nvim_create_autocmd("FileType", {
	pattern = "man",
	command = "wincmd o", -- Closes all other windows when opening a man page
})

vim.keymap.set("n", "<A-Z>", "<cmd>Telescope undo<cr>", { desc = "Undo history" })
-- Undo tree keybinding

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

--Experimental

vim.api.nvim_create_user_command("PdfView", function()
	local file = vim.fn.expand("%")
	vim.fn.jobstart({ "zathura", file }, { detach = true })
end, {})

-- More robust temporary directory handling
vim.o.directory = os.getenv("HOME") .. "/.cache/nvim/swap//"
vim.o.undodir = os.getenv("HOME") .. "/.cache/nvim/undo//"
vim.o.backupdir = os.getenv("HOME") .. "/.cache/nvim/backup//"

-- Ensure directories exist
vim.fn.mkdir(vim.o.directory, "p")
vim.fn.mkdir(vim.o.backupdir, "p")
vim.fn.mkdir(vim.o.undodir, "p")

-- Go to the definition line or file

vim.keymap.set("n", "<leader>vh", function()
	vim.cmd("vsplit | norm gf")
end, { desc = "Open header file in vertical split" })

vim.keymap.set("n", "<M-g>", function()
	vim.cmd("Git") -- Open Git status
	vim.cmd("wincmd H") -- Move to horizontal split
	vim.cmd("belowright Git log --graph --oneline --decorate") -- Show Git graph
end, { desc = "Fugitive Git Status & Graph" })
-- When delete it don't paste it in clipboard
vim.keymap.set("n", "d", '"_d', { noremap = true })
vim.keymap.set("n", "D", '"_D', { noremap = true })
vim.keymap.set("v", "d", '"_d', { noremap = true })

-- Enhanced Visual Mode Replace (with 'y/n' prompts and proper range handling)

vim.keymap.set("x", "r", function()
	local buf = 0
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local start_row = start_pos[2] - 1
	local start_col = start_pos[3] - 1
	local end_row = end_pos[2] - 1
	local end_col = end_pos[3]

	-- Handle column ordering (fix for visual block mode)
	if start_row == end_row and start_col > end_col then
		start_col, end_col = end_col, start_col
	end

	-- Clamp end_col to the line length
	local end_line = vim.api.nvim_buf_get_lines(buf, end_row, end_row + 1, false)[1] or ""
	if end_col > #end_line then
		end_col = #end_line
	end

	-- Get the selected text
	local selected_lines = vim.api.nvim_buf_get_text(buf, start_row, start_col, end_row, end_col, {})
	local selection = table.concat(selected_lines, "\n")
	if selection == "" then
		return
	end

	-- Ask user for replacement
	local replacement = vim.fn.input("Replace with: ")
	if replacement == "" then
		return
	end

	-- Global or once?
	local is_global = vim.fn.input("Replace globally? (y/n): ")
	if is_global ~= "y" and is_global ~= "n" then
		return
	end

	if is_global == "y" then
		-- Get all buffer content
		local all_lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
		local all_text = table.concat(all_lines, "\n")

		-- Exact match?
		local exact_word = vim.fn.input("Match exact word only? (y/n): ")
		local pattern = vim.pesc(selection)

		if exact_word == "y" then
			pattern = "%f[%w]" .. pattern .. "%f[%W]"
		end

		-- Perform global replacement
		local new_text = all_text:gsub(pattern, replacement)
		local new_lines = vim.split(new_text, "\n")

		-- Replace entire buffer content
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
	else
		-- Just replace selected text once
		local new_text = selection:gsub(vim.pesc(selection), replacement, 1)
		vim.api.nvim_buf_set_text(buf, start_row, start_col, end_row, end_col, vim.split(new_text, "\n"))
	end
end, { desc = "Interactive visual mode replace" })

-- follow curely braces
-- in your LazyVim config or keymaps
vim.keymap.set("n", "<leader>%", "%", { desc = "Jump to matching brace" })

-- Cut with x in Visual mode
vim.keymap.set("x", "x", '"+d', { noremap = true, silent = true })
-- Open definitions in vertical splits rather than on same buffer (Not working)
-- vim.keymap.set("n", "gd", function()
-- 	require("telescope.builtin").lsp_definitions({
-- 		jump_type = "vsplit",
-- 	})
-- end, { desc = "Go to definition in vertical split" })

-- NOte taking bold and text highlighting
-- Utility function to get visual selection range
local function get_visual_range()
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	return start_pos, end_pos
end

-- Function to highlight selection with given highlight group
local function highlight_selection(hl_group)
	local start_pos, end_pos = get_visual_range()
	-- Clear previous match
	vim.cmd("call matchdelete(99)")
	-- Add the new match
	vim.cmd(
		string.format(
			"call matchadd('%s', '\\%%%dl\\%%>%dc\\_.*\\%%<%dl\\%%<%dc', 99)",
			hl_group,
			start_pos[2],
			start_pos[3] - 1,
			end_pos[2],
			end_pos[3]
		)
	)
end

-- Notes taking shortcuts
vim.keymap.set("v", "<C-b>", function()
	vim.fn.feedkeys(":lua ChooseBackgroundColor()<CR>", "n")
end, { noremap = true, silent = true })

function ChooseBackgroundColor()
	vim.ui.input({ prompt = "Choose background: (b)lue, (r)ed, (y)ellow: " }, function(choice)
		if choice == "b" then
			apply_highlight("BlueBg")
		elseif choice == "r" then
			apply_highlight("RedBg")
		elseif choice == "y" then
			apply_highlight("YellowBg")
		end
	end)
end

-- Define highlight groups
vim.api.nvim_set_hl(0, "BlueText", { fg = "#0000ff" })
vim.api.nvim_set_hl(0, "RedText", { fg = "#ff0000" })
vim.api.nvim_set_hl(0, "YellowText", { fg = "#ffff00" })

vim.api.nvim_set_hl(0, "BlueBg", { bg = "#0000ff" })
vim.api.nvim_set_hl(0, "RedBg", { bg = "#ff0000" })
vim.api.nvim_set_hl(0, "YellowBg", { bg = "#ffff00" })

vim.api.nvim_set_hl(0, "BoldText", { bold = true })

-- Optional: clear highlights mapping (you might want to reset)
vim.keymap.set("n", "<leader>ch", function()
	local ns = vim.api.nvim_create_namespace("visual_highlight")
	vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
end, { noremap = true, silent = true })

-- Double click to go to definition
vim.api.nvim_set_keymap(
	"n",
	"<2-LeftMouse>",
	"<cmd>lua vim.lsp.buf.definition()<CR>",
	{ noremap = true, silent = true }
)
