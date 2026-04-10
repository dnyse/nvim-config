require("trouble").setup({
	focus = true,
})

vim.keymap.set("n", "<leader>dw", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Open trouble workspace diagnostics" })
vim.keymap.set("n", "<leader>dd", "<cmd>Trouble diagnostics toggle filter.buf=0 win.position=right<CR>", { desc = "Open trouble document diagnostics" })
vim.keymap.set("n", "cq", "<cmd>Trouble toggle<CR>", { desc = "Open trouble quickfix list" })
vim.keymap.set("n", "cn", "<cmd>Trouble next<CR>", { desc = "Next trouble quickfix list" })
vim.keymap.set("n", "cp", "<cmd>Trouble prev<CR>", { desc = "Prev trouble quickfix list" })
vim.keymap.set("n", "<leader>tl", "<cmd>Trouble loclist toggle<CR>", { desc = "Open trouble location list" })
vim.keymap.set("n", "<leader>td", "<cmd>Trouble todo toggle<CR>", { desc = "Open todos in trouble" })
