local setup = function()
	local lint = require("lint")

	lint.linters_by_ft = {
		python = { "pylint" },
		-- cpp = { "cppcheck" },
		go = { "golangcilint" },
		nix = { "nix" },
		lua = { "luacheck" },

	}

	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_augroup,
		callback = function()
			lint.try_lint()
		end,
	})

	vim.keymap.set("n", "<leader>l", function()
		lint.try_lint()
	end, { desc = "Trigger linting for current file" })
end

return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = setup,
}
