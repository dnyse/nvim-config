local setup = function()
	local cmp = require("cmp")
	local lspkind = require("lspkind")
	local luasnip = require("luasnip")
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	vim.opt.completeopt = "menu,menuone,noselect"
	vim.opt.shortmess:append("c")

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = {
			["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
			["<C-c>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({ select = false }),
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "lazydev" },
			{ name = "luasnip" },
			{ name = "path" },
			{ name = "latex_symbols" },
			{ name = "buffer" },
			{ name = "render-markdown" },
		},
		experimental = {
			native_menu = false,
			ghost_text = true,
		},
		formatting = {
			format = lspkind.cmp_format({ with_text = true, maxwidth = 50 }),
		},
		window = {
			documentation = cmp.config.window.bordered({ border = "single" }),
		},
	})
end

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "kdheepak/cmp-latex-symbols" },
		{ "rcarriga/cmp-dap" },
		{ "onsails/lspkind-nvim" },
	},
	config = setup,
}
