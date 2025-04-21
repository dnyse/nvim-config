local setup = function()
	require("lualine").setup({
		options = {
			icons_enabled = true,
			-- theme = "orca",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
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
			lualine_a = { "mode" },
			lualine_b = {
				"branch",
				"diff",
				{
					"diagnostics",
					symbols = {
						error = "x",
						warn = "!",
						info = "󰛄 ",
						hint = "󰌵 ",
					},
				},
			},
			lualine_c = { "filename" },
			lualine_x = {
				{
					require("noice").api.statusline.mode.get,
					cond = require("noice").api.statusline.mode.has,
					color = { fg = "#bf616a" },
				},
				"encoding",
				"fileformat",
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
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
	-- TODO: (dhub) Clean this mess up
	vim.cmd [[
	hi lualine_a_normal guifg=#eaebed
	hi lualine_b_normal guifg=#eaebed
	hi lualine_c_normal guifg=#eaebed
	hi lualine_a_insert guifg=#eaebed
	hi lualine_b_insert guifg=#eaebed
	hi lualine_c_insert guifg=#eaebed
	hi lualine_a_visual guifg=#eaebed
	hi lualine_b_visual guifg=#eaebed
	hi lualine_c_visual guifg=#eaebed
	hi lualine_a_command guifg=#eaebed
	hi lualine_b_command guifg=#eaebed
	hi lualine_c_command guifg=#eaebed
	hi lualine_a_replace guifg=#eaebed
	hi lualine_b_replace guifg=#eaebed
	hi lualine_c_replace guifg=#eaebed
	hi lualine_a_terminal guifg=#eaebed
	hi lualine_b_terminal guifg=#eaebed
	hi lualine_c_terminal guifg=#eaebed
	]]
end
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = setup,
}
