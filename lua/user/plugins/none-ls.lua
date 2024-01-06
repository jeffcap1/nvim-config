return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- linters
				null_ls.builtins.diagnostics.eslint_d,
				null_ls.builtins.diagnostics.phpcs,
				null_ls.builtins.diagnostics.ruff,

				-- formatters
				null_ls.builtins.formatting.htmlbeautifier,
				null_ls.builtins.formatting.phpcsfixer,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.stylua,
			},
		})
		vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, {})
	end,
}
