require("nvim-treesitter").setup({
	auto_install = true,
	ensure_installed = {
		"bash", "c", "cpp", "go", "javascript", "json", "latex",
		"lua", "markdown", "markdown_inline", "nix", "python",
		"rust", "toml", "typescript", "yaml",
	},
	highlight = {
		enable = true,
	},
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

-- nvim-treesitter-textobjects: keymaps use module functions directly (new API)
local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")

local select_maps = {
	["af"] = { query = "@function.outer",    desc = "Select outer function" },
	["if"] = { query = "@function.inner",    desc = "Select inner function" },
	["as"] = { query = "@class.outer",       desc = "Select outer class" },
	["is"] = { query = "@class.inner",       desc = "Select inner class" },
	["ac"] = { query = "@conditional.outer", desc = "Select outer conditional" },
	["ic"] = { query = "@conditional.inner", desc = "Select inner conditional" },
	["al"] = { query = "@loop.outer",        desc = "Select outer loop" },
	["il"] = { query = "@loop.inner",        desc = "Select inner loop" },
	["ab"] = { query = "@block.outer",       desc = "Select outer block" },
	["ib"] = { query = "@block.inner",       desc = "Select inner block" },
	["am"] = { query = "@comment.outer",     desc = "Select outer comment" },
	["ci"] = { query = "@comment.inner",     desc = "Select inner comment" },
}

for key, def in pairs(select_maps) do
	vim.keymap.set({ "x", "o" }, key, function()
		select.select_textobject(def.query, "textobjects")
	end, { desc = def.desc })
end

local goto_next_start = {
	["<leader>nf"] = { query = "@function.outer",    desc = "Next function start" },
	["<leader>ns"] = { query = "@class.outer",       desc = "Next class start" },
	["<leader>nc"] = { query = "@conditional.outer", desc = "Next conditional start" },
	["<leader>nl"] = { query = "@loop.outer",        desc = "Next loop start" },
	["<leader>nb"] = { query = "@block.outer",       desc = "Next block start" },
}

local goto_prev_start = {
	["<leader>Nf"] = { query = "@function.outer",    desc = "Previous function start" },
	["<leader>Ns"] = { query = "@class.outer",       desc = "Previous class start" },
	["<leader>Nc"] = { query = "@conditional.outer", desc = "Previous conditional start" },
	["<leader>Nl"] = { query = "@loop.outer",        desc = "Previous loop start" },
	["<leader>Nb"] = { query = "@block.outer",       desc = "Previous block start" },
}

for key, def in pairs(goto_next_start) do
	vim.keymap.set("n", key, function()
		move.goto_next_start(def.query, "textobjects")
	end, { desc = def.desc })
end

for key, def in pairs(goto_prev_start) do
	vim.keymap.set("n", key, function()
		move.goto_previous_start(def.query, "textobjects")
	end, { desc = def.desc })
end
