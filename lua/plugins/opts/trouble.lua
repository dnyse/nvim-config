return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  opts = {
    focus = true,
  },
  cmd = "Trouble",
  keys = {
    { "<leader>dw", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open trouble workspace diagnostics" },
    { "<leader>dd", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Open trouble document diagnostics" },
    { "cq", "<cmd>Trouble toggle<CR>", desc = "Open trouble quickfix list" },
    { "cn", "<cmd>Trouble next<CR>", desc = "Next trouble quickfix list" },
    { "cp", "<cmd>Trouble prev<CR>", desc = "Prev trouble quickfix list" },
    { "<leader>ll", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
    { "<leader>td", "<cmd>Trouble todo toggle<CR>", desc = "Open todos in trouble" },
  },
}
