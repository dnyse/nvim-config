-- Minimal portable Neovim config — no LSP, with UI plugins
-- Drop as ~/.config/nvim/init.lua; requires Neovim 0.11+ (vim.pack built-in)

-- Leader (must be set before vim.pack.add)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.termguicolors = true

-- Neovim 0.12 ftplugins call vim.treesitter.start() automatically.
-- Silence the error when no parser is installed.
local _ts_start = vim.treesitter.start
vim.treesitter.start = function(...)
	pcall(_ts_start, ...)
end

vim.pack.add({
	"https://github.com/projekt0n/github-nvim-theme",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/folke/noice.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/lewis6991/gitsigns.nvim",
})

-- Reset loader cache so rtp entries added by vim.pack.add() are visible
vim.loader.reset()

-- ─── Plugin configuration ─────────────────────────────────────────────────────
-- All setups are wrapped in pcall: on a first run plugins may still be
-- installing; they will be fully active after restarting Neovim.

local function try(mod, fn)
	local ok, m = pcall(require, mod)
	if ok then
		fn(m)
	end
end

-- Colorscheme (first)
try("github-theme", function(m)
	m.setup({
		options = {
			transparent = true,
			styles = {
				comments = "NONE",
				functions = "italic,bold",
				keywords = "bold",
				variables = "bold",
				conditionals = "bold",
				constants = "bold,italic",
				operators = "bold",
				types = "bold",
			},
		},
	})
	vim.cmd("colorscheme github_dark_default")
end)

-- Noice (before lualine)
try("noice", function(m)
	m.setup({
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			lsp_doc_border = true,
		},
		views = {
			mini = { win_options = { winblend = 0 } },
		},
		lsp = { override = {} },
	})
end)

-- Lualine (after noice)
try("lualine", function(m)
	local noice_ok, noice = pcall(require, "noice")
	local noice_section = noice_ok
			and {
				noice.api.statusline.mode.get,
				cond = noice.api.statusline.mode.has,
				color = { fg = "#bf616a" },
			}
		or nil

	local x_sections = {
		{ "encoding", color = { fg = "#ffffff" } },
		{ "fileformat", color = { fg = "#ffffff" } },
		{ "filetype", color = { fg = "#ffffff" } },
	}
	if noice_section then
		table.insert(x_sections, 1, noice_section)
	end

	m.setup({
		options = {
			icons_enabled = true,
			component_separators = { left = vim.fn.nr2char(0xe0b1), right = vim.fn.nr2char(0xe0b3) },
			section_separators = { left = vim.fn.nr2char(0xe0b0), right = vim.fn.nr2char(0xe0b2) },
			globalstatus = false,
		},
		sections = {
			lualine_a = {
				{ "mode", color = { fg = "#ffffff" } },
			},
			lualine_b = {
				{ "branch", color = { fg = "#ffffff" } },
				{ "diff", color = { fg = "#ffffff" } },
			},
			lualine_c = {
				{
					function()
						return vim.fn.hostname():match("([^.]+)")
					end,
					color = { fg = "#ffffff" },
				},
				{ "filename", color = { fg = "#ffffff" } },
			},
			lualine_x = x_sections,
			lualine_y = { { "progress", color = { fg = "#ffffff" } } },
			lualine_z = { { "location", color = { fg = "#ffffff" } } },
		},
		inactive_sections = {
			lualine_c = { "filename" },
			lualine_x = { "location" },
		},
	})
end)

-- Gitsigns
try("gitsigns", function(m)
	m.setup({
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged_enable = true,
		current_line_blame = false,
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 1000,
		},
		current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
	})
end)

-- ─── Options ─────────────────────────────────────────────────────────────────
local o = vim.opt
local home = os.getenv("HOME")

o.hidden = true
o.ignorecase = true
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.wildmode = "longest:full,full"
o.cmdheight = 1
o.mouse = "niv"
o.scrolloff = 8
o.updatetime = 250
o.smartindent = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.expandtab = false
o.relativenumber = true
o.number = true
o.signcolumn = "yes"
o.wrap = false
o.cursorline = true
o.conceallevel = 0
o.undofile = true
o.undodir = home .. "/.local/share/nvim/undodir"
o.swapfile = false
o.spelllang = "en"
o.completeopt = "menu,menuone,noselect"
o.showmode = false
o.shortmess:append("c")
o.clipboard = "unnamedplus"

-- ─── Keymaps ─────────────────────────────────────────────────────────────────
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "H", "^", { desc = "First non-blank char" })
map("n", "L", "$", { desc = "End of line" })
map("v", "H", "^", { desc = "First non-blank char" })
map("v", "L", "$", { desc = "End of line" })

map("n", "<esc>", "<cmd>noh<CR>", { desc = "Clear search highlight" })

map("n", "Q", "<nop>", { desc = "Disable ex mode" })
map("n", "q:", "<nop>", { desc = "Disable command-line window" })

map("t", "<esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("v", ">", ">gv", { desc = "Indent and reselect" })
map("v", "<", "<gv", { desc = "Unindent and reselect" })

vim.cmd([[
  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv
]])

map("n", "Y", "y$", { desc = "Yank to end of line" })
map("n", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

map("i", "<c-o>", "<esc>gUawea", { desc = "Uppercase word" })
map("i", "<c-l>", "<esc>guawea", { desc = "Lowercase word" })

map("i", ",", ",<c-g>u")
map("i", ":", ":<c-g>u")
map("i", ";", ";<c-g>u")
map("i", ".", ".<c-g>u")

map("n", "<leader>w", "<cmd>update<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })

map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

map({ "n", "t" }, "<M-.>", "<cmd>vertical resize -5<cr>", { desc = "Decrease window width" })
map({ "n", "t" }, "<M-,>", "<cmd>vertical resize +5<cr>", { desc = "Increase window width" })

-- Gitsigns
map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle git blame" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<cr>", { desc = "Git diff" })
map("n", "]h", "<cmd>Gitsigns next_hunk<cr>", { desc = "Next hunk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", { desc = "Prev hunk" })

-- ─── Autocommands ─────────────────────────────────────────────────────────────
local aug = vim.api.nvim_create_augroup("minimal", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = aug,
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = aug,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local line_count = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= line_count then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = aug,
	callback = function()
		local pos = vim.api.nvim_win_get_cursor(0)
		vim.cmd([[%s/\s\+$//e]])
		vim.api.nvim_win_set_cursor(0, pos)
	end,
})
