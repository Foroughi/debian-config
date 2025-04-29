local opt = vim.opt -- aliasing

-- line number
opt.number = true
opt.relativenumber = true
--opt.signcolumn = "number"

-- tabs & intendation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- search
opt.ignorecase = true
opt.smartcase = true

-- appearance
opt.background = "dark"
opt.termguicolors = true
opt.showtabline = 0
opt.swapfile = false

vim.api.nvim_set_option("clipboard", "unnamedplus")
opt.mouse = ""
opt.splitright = true
opt.wrap = false

vim.opt.background = "dark"
vim.o.timeoutlen = 300
