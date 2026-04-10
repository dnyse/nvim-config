require("zellij-nav").setup({})

vim.keymap.set("n", "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>", { silent = true, desc = "navigate left or tab" })
vim.keymap.set("n", "<c-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "navigate down" })
vim.keymap.set("n", "<c-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "navigate up" })
vim.keymap.set("n", "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" })
