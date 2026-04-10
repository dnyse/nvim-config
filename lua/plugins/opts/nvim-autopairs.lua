local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
-- local cond = require("nvim-autopairs.conds")

npairs.setup({
	check_ts = true,
})

npairs.add_rule(Rule("$", "$", "tex"))
