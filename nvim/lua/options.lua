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

opt.swapfile = false

vim.api.nvim_set_option("clipboard", "unnamedplus")
opt.mouse = ""

opt.wrap = false

vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.opt.background = "dark"
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if vim.fn.argc() == 0 then
			require("telescope").extensions.file_browser.file_browser()
		end
	end,
})
