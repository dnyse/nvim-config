-- LSP Setup
local lspconfig = require("lspconfig")

local servers = { "clangd", "bashls", "pyright", "lua_ls", "texlab", "nil_ls", "gopls" }

local capabilities = vim.lsp.protocol.make_client_capabilities()

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("lsp.handlers").on_attach,
		capabilities = capabilities,
	}

	if server == "lua_ls" then
		local lua_ls_opts = require("lsp.settings.lua_ls")
		opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)
	end

	if server == "texlab" then
		local texlab_opts = require("lsp.settings.texlab")
		opts = vim.tbl_deep_extend("force", texlab_opts, opts)
	end

	if server == "clangd" then
		local clangd_opt = require("lsp.settings.clangd")
		opts = vim.tbl_deep_extend("force", clangd_opt, opts)
		vim.keymap.set(
			"n",
			"gh",
			"<cmd>ClangdSwitchSourceHeader<CR>",
			{ noremap = true, silent = true, buffer = bufnr }
		)
	end

	lspconfig[server].setup(opts)
end

require("lsp.handlers").setup()
