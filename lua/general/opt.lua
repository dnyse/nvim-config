-- Neovim Options
local o = vim.opt

-- $HOME
local home = os.getenv("HOME")

-- Settings
local indent = 4

o.termguicolors = true
o.hidden = true
o.ignorecase = true
o.smartcase = true
o.splitbelow = true
o.splitright = true
o.wildmode = "longest:full,full"
o.cmdheight = 1
o.mouse = "niv"
-- o.showmode = false
o.scrolloff = 8
o.undodir = home .. "/.local/share/nvim/undodir"
o.updatetime = 250
o.smartindent = true
o.shiftwidth = indent
o.tabstop = indent
o.softtabstop = indent
o.expandtab = false
o.relativenumber = true
o.number = true
o.wrap = false

-- o.colorcolumn = "80"

o.cursorline = true
-- o.concealcursor = ''
o.conceallevel = 0
o.undofile = true
o.swapfile = false

o.spelllang = "en"
-- o.spell = true
-- o.cmdheight = 1

o.completeopt = "menu,menuone,noselect"
o.shortmess:append("c")
o.showmode = false

vim.g.tex_flavor = "latex"
