return {
	"neovim/nvim-lspconfig",
	opts = {
		on_attach = function(client, bufnr)
			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
			end

			-- Open function definition in a vertical split using LSP
			map("n", "<leader>vd", function()
				vim.cmd("vsplit")
				vim.defer_fn(vim.lsp.buf.definition, 100)
			end, "LSP: Open definition in vertical split")
		end,
	},
}
