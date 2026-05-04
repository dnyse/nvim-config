local M = {}

M.setup = function()
	local border = "single"

	-- Use the modern signs.text API (replaces deprecated vim.fn.sign_define)
	vim.diagnostic.config({
		virtual_text = true,
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "x",
				[vim.diagnostic.severity.WARN]  = "!",
				[vim.diagnostic.severity.INFO]  = "󰛄",
				[vim.diagnostic.severity.HINT]  = "󰌵",
			},
		},
		float = {
			focusable = false,
			style = "minimal",
			border = border,
			source = "always",
			header = "",
			prefix = "",
		},
	})

	-- if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
	-- vim.lsp.inlay_hint.enable(args.buf, true)
	-- end

	local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or border
		return orig_util_open_floating_preview(contents, syntax, opts, ...)
	end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
-- M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)

M.on_attach = function(_, bufnr)
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local buf_set_keymap = vim.keymap.set
	local opts = { noremap = true, silent = true, buffer = bufnr }
	local function lsp_map(mode, lhs, rhs, desc)
		buf_set_keymap(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
	end

	lsp_map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "LSP go to declaration")
	lsp_map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", "LSP go to definition")
	lsp_map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", "LSP hover documentation")
	lsp_map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", "LSP go to implementation")
	lsp_map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "LSP signature help")
	lsp_map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "LSP add workspace folder")
	lsp_map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "LSP remove workspace folder")
	lsp_map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "LSP list workspace folders")
	lsp_map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", "LSP type definition")
	lsp_map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "LSP rename symbol")
	lsp_map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "LSP code action")
	buf_set_keymap("n", "gr", function()
		require("trouble").toggle("lsp_references")
	end, vim.tbl_extend("force", opts, { desc = "LSP references (trouble)" }))
	lsp_map("n", "<leader>of", "<cmd>lua vim.diagnostic.open_float()<CR>", "LSP open diagnostic float")
	lsp_map("n", "[u", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "LSP previous diagnostic")
	lsp_map("n", "]u", "<cmd>lua vim.diagnostic.goto_next()<CR>", "LSP next diagnostic")
	buf_set_keymap("n", "<leader>dc", function()
		require("trouble").toggle("document_diagnostics")
	end, vim.tbl_extend("force", opts, { desc = "LSP document diagnostics (trouble)" }))
	buf_set_keymap("n", "<leader>dC", function()
		require("trouble").toggle("workspace_diagnostics")
	end, vim.tbl_extend("force", opts, { desc = "LSP workspace diagnostics (trouble)" }))
	lsp_map("n", "<leader>mf", "<cmd>lua vim.lsp.buf.format{async = true}<CR>", "LSP format buffer")
	lsp_map("n", "<leader>pd", "<cmd> lua require('goto-preview').goto_preview_definition()<CR>", "LSP preview definition")
	lsp_map("n", "<leader>pi", "<cmd> lua require('goto-preview').goto_preview_implementation()<CR>", "LSP preview implementation")
	lsp_map("n", "<leader>cp", "<cmd> lua require('goto-preview').close_all_win()<CR>", "LSP close preview windows")
	lsp_map("n", "<leader>pr", "<cmd> lua require('goto-preview').goto_preview_references()<CR>", "LSP preview references")
	buf_set_keymap("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, vim.tbl_extend("force", opts, { desc = "LSP document symbols" }))
	buf_set_keymap("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, vim.tbl_extend("force", opts, { desc = "LSP workspace symbols" }))
end

return M
