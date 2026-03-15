local autocmd = vim.api.nvim_create_autocmd
-- local augroup = vim.api.nvim_create_autogroup

autocmd("FileType", {
	pattern = { "markdown", "tex" },
	command = "set wrap conceallevel=1",
})

autocmd("FileType", {
	pattern = { "markdown", "tex" },
	command = "set linebreak",
})

autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- NOTE: Ensures that when exiting NeoVim, Zellij returns to normal mode
vim.api.nvim_create_autocmd("VimLeave", {
    pattern = "*",
    command = "silent !zellij action switch-mode normal"
})
