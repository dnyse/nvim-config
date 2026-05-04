require("lualine").setup({
	options = {
		icons_enabled = true,
		-- theme = "orca",
		component_separators = { left = vim.fn.nr2char(0xe0b1), right = vim.fn.nr2char(0xe0b3) },
		section_separators = { left = vim.fn.nr2char(0xe0b0), right = vim.fn.nr2char(0xe0b2) },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { { "mode", color = { fg = "#ffffff" }  } },
		lualine_b = {
			{ "branch", color = { fg = "#ffffff" } },
			{ "diff", color = { fg = "#ffffff" } },
			{
				"diagnostics",
				color = { fg = "#ffffff" },
				symbols = {
					error = "x ",
					warn = "! ",
					info = "󰛄 ",
					hint = "󰌵 ",
				},
			},
		},
		lualine_c = { { "filename", color = { fg = "#ffffff" } } },
		lualine_x = {
			{
				require("noice").api.statusline.mode.get,
				cond = require("noice").api.statusline.mode.has,
				color = { fg = "#bf616a" },
			},
			{ "encoding", color = { fg = "#ffffff" } },
			{ "fileformat", color = { fg = "#ffffff" } },
			{ "filetype", color = { fg = "#ffffff" } },
		},
		lualine_y = { { "progress", color = { fg = "#ffffff" } } },
		lualine_z = { "location", color = { fg = "#ffffff" } },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
