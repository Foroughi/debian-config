vim.g.mapleader = ' '

--local utils = require('utils')

--utils.map('n', [[<C-n>]], ':NvimTreeToggle<CR>')


-- Yank into system clipboard
vim.keymap.set({'n', 'v'}, '<leader>c', '"+y') -- yank motion
vim.keymap.set({'n', 'v'}, '<leader>C', '"+Y') -- yank line

-- Delete into system clipboard
vim.keymap.set({'n', 'v'}, '<leader>x', '"+d') -- delete motion
vim.keymap.set({'n', 'v'}, '<leader>X', '"+D') -- delete line

-- Paste from system clipboard
vim.keymap.set('n', '<leader>v', '"+p')  -- paste after cursor
