-- Leader (must be set before vim.pack.add)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.opt.termguicolors = true

-- Build hooks (must be defined before vim.pack.add)
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		local plugin_path = vim.fn.stdpath("data") .. "/site/pack/nvim-pack/start/" .. name

		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end

		if name == "telescope-fzf-native.nvim" and kind == "install" then
			vim.fn.system({ "make", "-C", plugin_path })
		end

		if name == "LuaSnip" and kind == "install" then
			vim.fn.system({ "make", "-C", plugin_path, "install_jsregexp" })
		end
	end,
})

vim.pack.add({
	-- Colorschemes
	"https://github.com/projekt0n/github-nvim-theme",
	"https://github.com/kungfusheep/mfd.nvim",
	"https://github.com/serhez/teide.nvim",

	-- Core utilities
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-lua/popup.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/folke/snacks.nvim",

	-- UI
	"https://github.com/folke/noice.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/echasnovski/mini.nvim",

	-- File navigation
	"https://github.com/nvim-tree/nvim-tree.lua",
	"https://github.com/stevearc/oil.nvim",

	-- Fuzzy finding
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",

	-- Diagnostics & annotations
	"https://github.com/folke/trouble.nvim",
	"https://github.com/folke/todo-comments.nvim",

	-- LSP
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/folke/lazydev.nvim",

	-- Completion
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-buffer",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-nvim-lua",
	"https://github.com/saadparwaiz1/cmp_luasnip",
	"https://github.com/kdheepak/cmp-latex-symbols",
	"https://github.com/rcarriga/cmp-dap",
	"https://github.com/onsails/lspkind-nvim",

	-- Snippets
	{ src = "https://github.com/L3MON4D3/LuaSnip", name = "LuaSnip" },
	"https://github.com/rafamadriz/friendly-snippets",

	-- Treesitter
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	-- nvim-treesitter-refactor removed: incompatible with new nvim-treesitter API
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	-- playground is deprecated; removed

	-- Formatting & linting
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/mfussenegger/nvim-lint",

	-- Git
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/kdheepak/lazygit.nvim",

	-- Debugging
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/theHamsta/nvim-dap-virtual-text",
	"https://github.com/nvim-telescope/telescope-dap.nvim",
	"https://github.com/andrewferrier/debugprint.nvim",

	-- Editing
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/kylechui/nvim-surround",
	"https://github.com/numToStr/Comment.nvim",
	"https://github.com/chrisgrieser/nvim-scissors",

	-- Navigation & tools
	"https://github.com/rmagatti/goto-preview",
	"https://github.com/tzachar/highlight-undo.nvim",
	"https://github.com/mbbill/undotree",
	"https://github.com/swaits/zellij-nav.nvim",

	-- Language support
	"https://github.com/lervag/vimtex",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/catgoose/nvim-colorizer.lua", -- maintained fork of norcalli/nvim-colorizer.lua

	-- Terminal
	"https://github.com/akinsho/toggleterm.nvim",

	-- AI
	-- "https://github.com/NickvanDyke/opencode.nvim",
	"https://github.com/coder/claudecode.nvim",
})

-- Reset the loader cache so it picks up rtp entries added by vim.pack.add().
-- Without this, vim.loader may serve stale "not found" results from its disk cache.
vim.loader.reset()

-- Plugin configurations (order matters for interdependencies)
require("plugins.opts.github-theme")    -- colorscheme first
require("plugins.opts.mini_indentscope")
require("plugins.opts.noice")           -- before lualine (provides statusline API)
-- require("plugins.opts.opencode")
require("plugins.opts.claudecode")     -- before lualine; includes snacks
require("plugins.opts.nvim-tree")
require("plugins.opts.oil")
require("plugins.opts.todo")            -- before trouble
require("plugins.opts.trouble")         -- before telescope (telescope maps <c-t> to trouble)
require("plugins.opts.telescope")
require("plugins.opts.lualine")         -- after noice and claudecode
require("plugins.opts.toggleterm")
require("plugins.opts.nvim-autopairs")  -- before cmp
require("plugins.opts.luasnip")         -- before cmp
require("plugins.opts.nvim-cmp")
require("plugins.opts.lazydev")
require("plugins.opts.lspconfig")
require("plugins.opts.lint")
require("plugins.opts.conform")
require("plugins.opts.gitsigns")
require("plugins.opts.treesitter")
require("plugins.opts.context")
require("plugins.opts.dap")
require("plugins.opts.debugprint")
require("plugins.opts.goto-preview")
require("plugins.opts.highlight_undo")
require("plugins.opts.scissors")
require("plugins.opts.comment")
require("plugins.opts.nvim-surround")
require("plugins.opts.vimtex")
require("plugins.opts.md")
require("plugins.opts.undotree")
require("plugins.opts.lazygit")
require("plugins.opts.zellij")
require("plugins.opts.colorizer")
require("plugins.opts.mfd")
require("plugins.opts.teide")
