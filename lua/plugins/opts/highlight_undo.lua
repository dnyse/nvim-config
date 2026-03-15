return {
	"tzachar/highlight-undo.nvim",
	opts = {
		hlgroup = "@diff.plus",
		duration = 300,
		pattern = { "*" },
		ignored_filetypes = { "neo-tree", "fugitive", "TelescopePrompt", "mason", "lazy" },
		-- ignore_cb is in comma as there is a default implementation. Setting
		-- to nil will mean no default os called.
		-- ignore_cb = nil,
		config = function()
			require("highlight-undo").setup({})
		end,
	},
}
