local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		lua = { "stylua" },
		cpp = { "clang_format" },
		go = { "goimports", "gofmt" },
		python = { "black" },
		nix = { "alejandra", "nixfmt" },
		tex = { "latexindent" },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>mp", function()
	conform.format({
		lsp_fallback = true,
		async = false,
		timeout_ms = 500,
	})
end, { desc = "Format file or range (in visual mode)" })
