local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local new_maker = function(filepath, bufnr, opts)
	filepath = vim.fn.expand(filepath)
	Job:new({
		command = "file",
		args = { "--mime-type", "-b", filepath },
		on_exit = function(j)
			local mime_type = vim.split(j:result()[1], "/")[1]
			if mime_type == "text" then
				previewers.buffer_previewer_maker(filepath, bufnr, opts)
			else
				-- maybe we want to write something to the buffer here
				vim.schedule(function()
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
				end)
			end
		end,
	}):sync()
end

local setup = function()
	-- local actions = require("telescope.actions")
	local trouble = require("trouble.sources.telescope")
	require("telescope").setup({
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			buffer_previewer_maker = new_maker,
			preview = {
				filesize_limit = 0.1, -- MB
			},
			prompt_prefix = "> ",
			selection_caret = "> ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "flex",
			layout_config = {
				horizontal = {
					mirror = false,
				},
				vertical = {
					mirror = false,
				},
			},
			file_sorter = require("telescope.sorters").get_fuzzy_file,
			file_ignore_patterns = {},
			generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
			winblend = 0,
			border = {},
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			color_devicons = true,
			use_less = true,
			path_display = {},
			set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
			file_previewer = require("telescope.previewers").vim_buffer_cat.new,
			grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
			qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
			mappings = {
				i = { ["<c-t>"] = trouble.open },
				n = { ["<c-t>"] = trouble.open },
			},
		},
	})
end
return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/popup.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "folke/trouble.nvim" },
	},
	config = setup,
}
