-- LSP Setup
local servers = { "clangd", "bashls", "pyright", "lua_ls", "texlab", "nil_ls", "gopls" }

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Setup handlers first
require("lsp.handlers").setup()

-- Configure each LSP server
for _, server in pairs(servers) do
	local opts = {
		name = server,
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
	end

	-- Register the LSP configuration
	vim.lsp.config[server] = opts

	-- Enable the LSP for appropriate filetypes
	vim.api.nvim_create_autocmd("FileType", {
		pattern = vim.lsp.config[server].filetypes or "*",
		callback = function(args)
			vim.lsp.enable(server)
		end,
	})
end

-- Setup clangd keymap after buffers are attached
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "clangd" then
			vim.keymap.set(
				"n",
				"gh",
				"<cmd>ClangdSwitchSourceHeader<CR>",
				{ noremap = true, silent = true, buffer = args.buf }
			)
		end
	end,
})
