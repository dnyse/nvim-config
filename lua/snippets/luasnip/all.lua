local calculate_comment_string = require("Comment.ft").calculate
local utils = require("Comment.utils")

_G.luasnip = {}
_G.luasnip.vars = {
  username = 'clennys',
  email = 'dennys.huber@proton.me',
  github = 'https://github.com/clennys',
  real_name = 'Dennys Huber',
}

--- Get the comment string {beg,end} table
---@param ctype integer 1 for `line`-comment and 2 for `block`-comment
---@return table comment_strings {begcstring, endcstring}
local get_cstring = function(ctype)
	-- use the `Comments.nvim` API to fetch the comment string for the region (eq. '--%s' or '--[[%s]]' for `lua`)
	local cstring = calculate_comment_string({ ctype = ctype, range = utils.get_region() }) or vim.bo.commentstring
	-- as we want only the strings themselves and not strings ready for using `format` we want to split the left and right side
	local left, right = utils.unwrap_cstr(cstring)
	-- create a `{left, right}` table for it
	return { left, right }
end

local comment_strings = function(alias, name)
	return {
		f(function()
			return get_cstring(1)[1] .. " " .. alias .. ": (" .. name .. ") "
		end),
		i(1, "Write comment here"),
		t({ "", "" }),
		i(0),
	}
end

local username = "dhub"

-- TODO: (dhub) Figure out how to use autosnippet for snippetType and exculude it from the Telescope buffer type
return {
	s({ trig = "todo", snippetType = "snippet", desc = "TODO", wordTrig = true }, comment_strings("TODO", username)),
	s({ trig = "warn", snippetType = "snippet", desc = "WARN", wordTrig = true }, comment_strings("WARN", username)),
	s({ trig = "info", snippetType = "snippet", desc = "INFO", wordTrig = true }, comment_strings("INFO", username)),
	s({ trig = "fix", snippetType = "snippet", desc = "FIX", wordTrig = true }, comment_strings("FIX", username)),
}
