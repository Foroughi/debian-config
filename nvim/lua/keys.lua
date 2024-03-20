vim.g.mapleader = ' '
local opts = { noremap = true, silent = true }

-- Yank into system clipboard
vim.keymap.set({'n', 'v'}, '<leader>c', '"+y') -- yank motion
vim.keymap.set({'n', 'v'}, '<leader>C', '"+Y') -- yank line

-- Delete into system clipboard
vim.keymap.set({'n', 'v'}, '<leader>x', '"+d') -- delete motion
vim.keymap.set({'n', 'v'}, '<leader>X', '"+D') -- delete line

-- Paste from system clipboard
vim.keymap.set('n', '<leader>v', '"+p')  -- paste after cursor


-- to get used to vim key layout
vim.keymap.set({'n', 'v' , 'c' , 'i'}, '<Up>', '<Nop>', opts)
vim.keymap.set({'n', 'v' , 'c' , 'i'}, '<Down>', '<Nop>', opts)
vim.keymap.set({'n', 'v' , 'c' , 'i'}, '<Left>', '<Nop>', opts)
vim.keymap.set({'n', 'v' , 'c' , 'i'}, '<Right>', '<Nop>', opts)

vim.keymap.set({'n', 'v' , 'c' , 'i'}, '<PageUp>', '<Nop>', opts)
vim.keymap.set({'n', 'v' , 'c' , 'i'}, '<PageDown>', '<Nop>', opts)

vim.keymap.set({'n', 'v' , 'c' , 'i'}, '<Home>', '<Nop>', opts)
vim.keymap.set({'n', 'v' , 'c' , 'i'}, '<End>', '<Nop>', opts)

vim.keymap.set({'n', 'v' , 'c' , 'i'}, '<Insert>', '<Nop>', opts)
vim.keymap.set({'n', 'v' , 'c' , 'i'}, '<Delete>', '<Nop>', opts)
