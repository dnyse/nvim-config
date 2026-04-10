-- snacks is required by claudecode
require("snacks").setup({ input = {}, picker = {}, terminal = {} })

require("claudecode").setup({
	auto_start = true,
	track_selection = true,
	terminal = {
		split_side = "right",
		split_width_percentage = 0.30,
		provider = "snacks",
		auto_close = true,
	},
})

-- Toggle Claude (mirrors opencode's <C-a> toggle)
vim.keymap.set({ "n", "t" }, "<C-a>", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude Code" })

-- Focus / open Claude (mirrors opencode's <leader>ac ask)
vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude Code" })

-- Send visual selection to Claude (mirrors opencode's go / <C-x> select)
vim.keymap.set("v", "go", "<cmd>ClaudeCodeSend<cr>", { desc = "Send selection to Claude Code" })
vim.keymap.set({ "n", "x" }, "<C-x>", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude Code" })

-- Add current buffer to Claude context (similar to opencode's @this operator)
vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add buffer to Claude Code" })

-- Resume / continue sessions (no direct opencode equivalent)
vim.keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude Code session" })
vim.keymap.set("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude Code session" })

-- Diff accept / deny
vim.keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept Claude Code diff" })
vim.keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny Claude Code diff" })

-- Preserve increment/decrement since <C-a> and <C-x> are remapped
vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
