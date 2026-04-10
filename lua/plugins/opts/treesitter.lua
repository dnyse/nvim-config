require("nvim-treesitter").setup({
	auto_install = true,
	highlight = {
		enable = true,
	},
})

-- nvim-treesitter-textobjects: keymaps use module functions directly (new API)
local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")

local select_maps = {
	["af"] = "@function.outer",
	["if"] = "@function.inner",
	["as"] = "@class.outer",
	["is"] = "@class.inner",
	["ac"] = "@conditional.outer",
	["ic"] = "@conditional.inner",
	["al"] = "@loop.outer",
	["il"] = "@loop.inner",
	["ab"] = "@block.outer",
	["ib"] = "@block.inner",
	["am"] = "@comment.outer",
	["ci"] = "@comment.inner",
}

for key, query in pairs(select_maps) do
	vim.keymap.set({ "x", "o" }, key, function()
		select.select_textobject(query, "textobjects")
	end)
end

local goto_next_start = {
	["<leader>nf"] = "@function.outer",
	["<leader>ns"] = "@class.outer",
	["<leader>nc"] = "@conditional.outer",
	["<leader>nl"] = "@loop.outer",
	["<leader>nb"] = "@block.outer",
}

local goto_prev_start = {
	["<leader>Nf"] = "@function.outer",
	["<leader>Ns"] = "@class.outer",
	["<leader>Nc"] = "@conditional.outer",
	["<leader>Nl"] = "@loop.outer",
	["<leader>Nb"] = "@block.outer",
}

for key, query in pairs(goto_next_start) do
	vim.keymap.set("n", key, function()
		move.goto_next_start(query, "textobjects")
	end)
end

for key, query in pairs(goto_prev_start) do
	vim.keymap.set("n", key, function()
		move.goto_previous_start(query, "textobjects")
	end)
end
