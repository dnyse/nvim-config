-- Mappings
-- Helper Function
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end
-- Nvim
map("n", "H", "^", { desc = "Go to first non-blank character" })
map("n", "L", "$", { desc = "Go to end of line" })
map("v", "H", "^", { desc = "Go to first non-blank character" })
map("v", "L", "$", { desc = "Go to end of line" })
map("n", "<esc>", "<cmd>noh<CR>", { desc = "Clear search highlight" })
map("n", "Q", "<nop>", { desc = "Disable Q" })
map("n", "q:", "<nop>", { desc = "Disable command-line window" })
map("t", "<esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- map("n", "<C-s>", "<cmd>update<cr>")
map("v", ">", ">gv", { desc = "Indent and reselect" })
map("v", "<", "<gv", { desc = "Unindent and reselect" })
map("i", "<c-o>", "<esc>gUawea", { desc = "Uppercase word" })
map("i", "<c-l>", "<esc>guawea", { desc = "Lowercase word" })
map("n", "Y", "y$", { desc = "Yank to end of line" })
map("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
map("i", ",", ",<c-g>u", { desc = "Undo breakpoint on comma" })
map("i", ":", ":<c-g>u", { desc = "Undo breakpoint on colon" })
map("i", ";", ";<c-g>u", { desc = "Undo breakpoint on semicolon" })
map("i", ".", ".<c-g>u", { desc = "Undo breakpoint on period" })

vim.cmd([[
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
]])

-- Telescope
map("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Telescope find files" })
map("n", "<leader>t", "<cmd>Telescope tags<cr>", { desc = "Telescope tags" })
map("n", "go", "<cmd>Telescope buffers<cr>", { desc = "Telescope buffers" })
map("n", "<leader>ht", "<cmd>Telescope help_tags<cr>", { desc = "Telescope help tags" })
map("n", "<leader>ch", "<cmd>Telescope command_history<cr>", { desc = "Telescope command history" })
map("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", { desc = "Telescope git commits" })
map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Telescope git status" })
map("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", { desc = "Telescope git branches" })
map("n", "<leader>rg", "<cmd>Telescope registers<cr>", { desc = "Telescope registers" })
map("n", "<leader>ct", "<cmd>Telescope quickfix<cr>", { desc = "Telescope quickfix" })
map("n", "<leader>ss", "<cmd>Telescope live_grep<cr>", { desc = "Telescope live grep" })
map("n", "ma", "<cmd>Telescope keymaps<cr>", { desc = "Telescope keymaps" })
map("n", "<leader>pd", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Telescope LSP document symbols" })
map("n", "<leader>sg", "<cmd>Telescope spell_suggest<cr>", { desc = "Telescope spell suggest" })

-- Nvim-Tree
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })

-- Undotree
map("n", "<leader>ut", "<cmd>UndotreeToggle<cr>", { desc = "Toggle undo tree" })

-- Debugprint
map("n", "<Leader>dv", function()
	return require("debugprint").debugprint({ variable = true })
end, {
	expr = true,
	desc = "Debugprint variable below",
})
map("n", "<Leader>dl", function()
	return require("debugprint").debugprint()
end, {
	expr = true,
	desc = "Debugprint line below",
})

map("n", "<Leader>Dv", function()
	return require("debugprint").debugprint({ above = true, variable = true })
end, {
	expr = true,
	desc = "Debugprint variable above",
})

map("n", "<Leader>Dl", function()
	return require("debugprint").debugprint({ above = true, variable = true })
end, {
	expr = true,
	desc = "Debugprint line above",
})

map("n", "<Leader>do", function()
	return require("debugprint").debugprint({ motion = true })
end, {
	expr = true,
	desc = "Debugprint motion",
})

map("n", "<C-f>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })

map("n", "<leader>se", function()
	require("scissors").editSnippet()
end, { desc = "Edit snippet" })

-- When used in visual mode prefills the selection as body.
map({ "n", "x" }, "<leader>sa", function()
	require("scissors").addNewSnippet()
end, { desc = "Add new snippet" })

-- Window resizing
map({ "n", "t" }, "<M-.>", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })
map({ "n", "t" }, "<M-,>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })
